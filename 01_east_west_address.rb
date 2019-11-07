require 'pry'

# original
class Address
  attr_reader :street, :city, :state, :zipcode, :country
  def initialize(**args)
    @street  = args[:street]
    @city    = args[:city]
    @state   = args[:state]
    @zipcode = args[:zipcode]
    @country = args[:country]
  end
end

class Person
  attr_reader :name, :address
  def initialize(name:, address: nil, addr_args: {})
    @name    = name
    @address = address || Address.new(addr_args)
  end
  # format correctly depending on the info we have
  # BAD CODE!!! (we know too much about Address) - Demeter Violation!!
  def display_address
    ''.tap do |string|
      string << "#{name}\n"
      string << address.street  unless address.street&.empty?
      string << "\n"            unless string.empty?
      string << address.city    unless address.city&.empty?
      string << ", "                if !address.city&.empty? && (!address.state&.empty? || !address.zipcode.empty?)
      string << address.state   unless address.state&.empty?
      string << " "             unless address.state&.empty? || address.zipcode&.empty?
      string << address.zipcode unless address.state&.empty?
      string << "\n"            unless address.country&.empty?
      string << address.country unless address.country&.empty?
    end
  end
end

usa_params = {
  street:  '90 High Street',
  city:    'Bristol',
  state:   'Rhode Island',
  zipcode: '02809',
  country: 'USA',
}

# what about ch adresses (& old addresses?)
# what about privacy for product reviews & full adress for shipping

address = Address.new(usa_params)
person  = Person.new(name: 'Bill Tihen', address: address)
puts person.display_address

puts "*" * 50

puts "*" * 50
# address = Address.new(usa_params)
person  = Person.new(name: 'Bill Tihen', addr_args: usa_params )
puts person.display_address
