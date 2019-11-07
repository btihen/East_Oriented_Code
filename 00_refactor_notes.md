#########################
# PATH to East Oriented #
#########################

# original
class Person 
    attr_reader :address 
    # street #house num 
    # city, ST zipcode
    # format correctly depending on the info we have
    # BAD CODE!!! (we know too much about Address)
    def display_address 
        ''.tap do |string|
            string << address.street  unless address.street&.empty?
            string << "\n"            unless string.empty? 
            string << address.city    unless address.city&.empty? 
            string << ", "                if !address.city&.empty? && (!address.state&.empty? || !address.zipcode.empty?)
            string << address.state     unless address.state&.empty?            
            string << " "             unless address.state&.empty? || address.zipcode&.empty? 
            string << address.zipcode   unless address.state&.empty? 
        end
    end 
end

# Refactor 1
class Person 
    attr_reader :address 
    def display_address
        address.display
        self
    end
end
class Address 
    # ok to query self (rule 2)
    def diplay(line_break="\n")
        state_and_zipcode = [state, zipcode].compact.join(' ')
        state_and_zipcode = nil    if state_and_zipcode.empty?

        city_state_zip    = [city, state_and_zipcode].compact.join(' ')
        city_state_zip    = nil    if city_state_zip.empty?

        # [street, city_state_zip].compact.join("\n")
        [street, city_state_zip].compact.join(line_break)
    end
end



# Refactor 2
class Person 
    def display_address
        address.display(template=AddressTextTemplate.new)
        self
    end
end
class Address 
    # ok to query self (rule 2)
    def diplay(template)
        template.display_address(self)
        self
    end
end
class AddressTextTemplate 
    # ok to query self (rule 2)
    def display_address(address)
        state_and_zipcode = [address.state, address.zipcode].compact.join(' ')
        state_and_zipcode = nil    if state_and_zipcode.empty?

        city_state_zip    = [address.city, state_and_zipcode].compact.join(', ')
        city_state_zip    = nil    if city_state_zip.empty?

        STDOUT.puts [address.street, city_state_zip].compact.join("\n")

        self
    end
end
class AddressHtmlTemplate 
    # ok to query self (rule 2)
    def display_address(address)
        state_and_zipcode = [address.state, address.zipcode].compact.join(' ')
        state_and_zipcode = nil    if state_and_zipcode.empty?

        city_state_zip    = [address.city, state_and_zipcode].compact.join(', ')
        city_state_zip    = nil    if city_state_zip.empty?


        File.open 'address.html' do |file|
            file.write [address.street, city_state_zip].compact.join("<br/>")
        end

        self
    end
end

# Refactor 3
# make it hard to violate demeter!  block querying (send value objects)
class Person 
    def display_address
        address.display(template=AddressTextTemplate.new)
        self
    end
    private 
    attr_reader :address 
end
class Address 
    # ok to query self (rule 2)
    def diplay(template)
        template.display_address(self.to_value)
        self
    end
    private
    attr_reader :street, :city, :state, :zipcode
    # create a value object
    require 'ostruct'
    def to_value      # protect privacy - no street address to display
        OpenStruct.new(street: nil, city: city, state: state, zipcode: zipcode)
    end
    def to_value_shippable  # when priveledge user needs to ship package to user
        OpenStruct.new(street: street, city: city, state: state, zipcode: zipcode)
    end
end
class AddressTextTemplate 
    # ok to query self (rule 2)
    def display_address(address)
        state_and_zipcode = [address.state, address.zipcode].compact.join(' ')
        state_and_zipcode = nil    if state_and_zipcode.empty?

        city_state_zip    = [address.city, state_and_zipcode].compact.join(', ')
        city_state_zip    = nil    if city_state_zip.empty?

        STDOUT.puts [address.street, city_state_zip].compact.join("\n")

        self
    end
end
class AddressHtmlTemplate 
    # ok to query self (rule 2)
    def display_address(address)
        state_and_zipcode = [address.state, address.zipcode].compact.join(' ')
        state_and_zipcode = nil    if state_and_zipcode.empty?

        city_state_zip    = [address.city, state_and_zipcode].compact.join(', ')
        city_state_zip    = nil    if city_state_zip.empty?


        File.open 'address.html' do |file|
            file.write [address.street, city_state_zip].compact.join("<br/>")
        end

        self
    end
end
