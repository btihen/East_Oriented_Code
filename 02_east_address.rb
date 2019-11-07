require 'pry'
require 'ostruct'

class Person
  def initialize(name:, address: nil, addr_args: {})
    @name     = name
    @address  = address || Address.new(addr_args)
  end
  def display_address(template: FormatTemplate::Text.new)
    address.display(name: name, template: template)
    self
  end
  # private
  # use 'protected' over private when using decorators
  protected
  attr_reader :name, :address
end


class Address
  def initialize(**args)
    @street   = args[:street]
    @house_nr = args[:house_nr]
    @city     = args[:city]
    @state    = args[:state]
    @zipcode  = args[:zipcode]
    @country  = args[:country]
  end
  # ok to query self (rule 2)
  def display(name:, template:)
    template.display_address(name, self.send(:export_value))
    self
  end
  # private
  # use 'protected' over private when using decorators
  protected
  attr_reader :street, :city, :state, :zipcode, :country
  # creates a hash of instance attributes
  # {street: street, city: city, state: state, zipcode: zipcode, country: country}
  # https://stackoverflow.com/questions/11925855/get-all-instance-variables-declared-in-class
  def instance_vars_hash
    self.instance_variables.each_with_object({}) do |attrib, export|
      export[attrib.to_s.gsub('@','').to_sym] = self.instance_variable_get(attrib)
    end
  end
  # create an exportable value object - looks like:
  # OpenStruct.new(street: street, city: city, state: state, zipcode: zipcode, country: country)
  def export_value
    OpenStruct.new(instance_vars_hash)
  end
end

module FormatTemplate
  class Text
    # ok to query self (rule 2)
    def display_address(name, address)
      state_and_zipcode = [address.state, address.zipcode].compact.join(' ')
      state_and_zipcode = nil    if state_and_zipcode.empty?

      city_state_zip    = [address.city, state_and_zipcode].compact.join(', ')
      city_state_zip    = nil    if city_state_zip.empty?

      STDOUT.puts [name, address.street, city_state_zip].compact.join("\n")

      self
    end
  end
  class Html
    # ok to query self (rule 2)
    def display_address(name, address)
      state_and_zipcode = [address.state, address.zipcode].compact.join(' ')
      state_and_zipcode = nil    if state_and_zipcode.empty?

      city_state_zip    = [address.city, state_and_zipcode].compact.join(', ')
      city_state_zip    = nil    if city_state_zip.empty?

      puts [name, address.street, city_state_zip].compact.join("<br/>\n")
      # File.open 'address.html' do |file|
      #   file.write [name, address.street, city_state_zip].compact.join("<br/>\n")
      # end

      self
    end
  end
end


swiss_params = {
  street:  'Hühnerbühlstr 4',
  city:    'Bolligen',
  state:   'Bern',
  zipcode: '3065',
  country: 'Switzerland',
}

usa_params = {
  street:  '90 High Street',
  city:    'Bristol',
  state:   'Rhode Island',
  zipcode: '02809',
  country: 'USA',
}

puts "*" * 15
address = Address.new(swiss_params)
person  = Person.new(name: 'Bill Tihen', address: address)
person.display_address

puts "*" * 15
# address = Address.new(usa_params)
person  = Person.new(name: 'William Tihen', addr_args: usa_params)
person.display_address

puts "*" * 15
person.display_address(template: FormatTemplate::Html.new)

puts "*" * 15
person.display_address.
       display_address(template: FormatTemplate::Html.new)
