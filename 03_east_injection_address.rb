# require 'pry'
# require 'ostruct'
require './02_east_address'

# method override (without monkey patch) - with new feature and leaves old stuff alone
# class ScopedPerson < Person
class ScopedPerson < DelegateClass(Person)
  def initialize(**args)
    super(Person.new(args))
  end
  # delegate :id, :to => :__getobj__        # needed by rails
  def display_address(template: FormatTemplate::Text.new, scope: DataScope::MinimalInfo.new)
    address.display(name: name, template: template, scope: scope)
    self
  end
end

# class ScopedAddress < Address
class ScopedAddress < DelegateClass(Address)
  def initialize(**args)
    super( Address.new(args) )              # Step 2
  end
  # delegate :id, :to => :__getobj__        # needed by rails
  def display(name:, template:, scope: DataScope::MinimalInfo.new)
    scoped_value = scope.call(instance_vars_hash)
    template.display_address( name, scoped_value)
    self
  end
end

module DataScope
  class ShippingInfo
    def call(attribs)
      OpenStruct.new( attribs )
    end
  end
  class MinimalInfo
    def call(attribs)
      OpenStruct.new( state: attribs[:state],  country: attribs[:country] )
      # acts just like a hash: address.street returns 'nil'
      # OpenStruct.new( street: nil, city: nil, state: attribs[:state],
      #                 zipcode: nil, country: attribs[:country] )
    end
  end
end

module CountryLayout
  def self.call(address)
    const_get( (address.country.to_s.downcase || 'usa').to_s.capitalize ).lines(address)
  end
  module Usa
    def self.lines(address)
      state_and_zipcode = [address.state, address.zipcode].compact.join(' ')
      state_and_zipcode = nil                    if state_and_zipcode.empty?

      city_state_zip    = [address.city, state_and_zipcode].compact.join(', ')
      city_state_zip    = nil                    if city_state_zip.empty?
      [address.street, city_state_zip, address.country].compact
    end
  end
  module Switzerland
    def self.lines(address)
      zip_city = [address.zipcode, address.city].compact.join(' ')
      zip_city = nil                             if zip_city.empty?
      kanton   = nil
      kanton   = address.state                   if zip_city.nil?
      kanton   = "(#{address.state})"            if zip_city && address.state

      zip_city_kanton = [address.zipcode, address.city, kanton].compact.join(' ')
      zip_city_kanton = nil                      if zip_city_kanton.empty?

      [address.street, zip_city_kanton, address.country].compact
    end
  end
end

# With country - we can now simplify templates
module FormatTemplate
  class Text
    def display_address(name, address)
      address_lines = CountryLayout.call(address)
      puts [name, address_lines].flatten.compact.join("\n") + "\n----------\n"
      self
    end
  end
  class Html
    def display_address(name, address)
      address_lines = CountryLayout.call(address)
      puts [name, address_lines].flatten.compact.join("<br/>\n") + "\n<hr/>\n"
      self
    end
  end
end


bern_params = {
  street:     'Hühnerbühlstr',
  house_nr:   '4',
  appartment: 'Attica Rechts',
  city:       'Bolligen',
  state:      'Bern',
  zipcode:    '3065',
  country:    'Switzerland',
}

ti_params = {
  house_name: 'Casa Vechia',
  street:     'Corte di Bigogno',
  house_nr:   '2',
  city:       'Agra (Bigogno)',
  state:      'Ticino',
  zipcode:    '6927',
  country:    'Switzerland',
}

usa_params = {
  house_nr:   '90',
  street:     'High Street',
  city:       'Bristol',
  state:      'Rhode Island',
  zipcode:    '02809',
  country:    'USA',
}


puts "*" * 15

address = ScopedAddress.new(usa_params)
person  = ScopedPerson.new(name: 'William Tihen', address: address)
# person.display_address
person.display_address(template: FormatTemplate::Html.new)

puts "*" * 15
address = ScopedAddress.new(bern_params)
person  = ScopedPerson.new(name: 'Bill Tihen', address: address)
person.display_address

puts "*" * 15

address = ScopedAddress.new(usa_params)
person  = ScopedPerson.new(name: 'William Tihen', address: address)
person.display_address(template: FormatTemplate::Html.new, scope: DataScope::ShippingInfo.new)

puts "*" * 15
address = ScopedAddress.new(bern_params)
person  = ScopedPerson.new(name: 'Bill Tihen', address: address)
person.display_address(scope: DataScope::ShippingInfo.new)
