# Helpers experiments

puts
puts "*****"
puts

class Cook 
	def make_a_sandwich(type='ham') 
		puts "a #{type} sandwich"
		self
	end
end
class Person
	def order_a_sandwich(cook:, type: 'ham')
		cook.make_a_sandwich(type)
		self
	end
end

puts "Simple"
puts "------"
me = Person.new
me.order_a_sandwich(cook: Cook.new)
puts
puts "*****"
puts


# use forwardable - to avoid defining twice
# but then its actually its a query now & cook MUST already be eastward!
require 'forwardable'
class Person 
	extend Forwardable
	delegate :make_a_sandwich    => :cook
	alias_method :order_a_sandwich, :make_a_sandwich
	def initialize(cook:)
		@cook = cook 
	end
	private 
	attr_reader :cook
end

puts "Forwardable"
puts "-----------"
me = Person.new(cook: Cook.new)
me.order_a_sandwich
puts
puts "*****"
puts



# gem direction is very simple 
# give command a hash, keys are the methods, values are accessors to operate on
module Eastward 
	def command(options)
		method_defs = []
		# loop through hash of methods and objects to operate on (butler in above case)
		options.each_pair do |key, value|
			Array(key).map do |command_name|
				method_defs.unshift %{
					def #{command_name}(*args, &block)
						#{value}.__send__(:#{command_name}, *args, &block)
						self
					end
				}
			end
		end
		self.class_eval method_defs.join(' ') # actually executes code built above
	end
end

class Butler 
	def greet_people 
		puts "Greetings!"
	end
	def serve_drinks 
		puts "Your drink is served"
	end
end

# look at module - to force commands not queries!
# even when not already Eastward
class Person 
	extend Eastward
	command [:greet_people, :serve_drinks] => :butler
	command :make_a_sandwich               => :cook
	alias_method :order_a_sandwich, :make_a_sandwich

	def initialize(cook:, butler:)
		@cook   = cook 
		@butler = butler 
	end
	private
	attr_reader :cook, :butler
end

puts "Eastward Module"
puts "---------------"
me = Person.new(cook: Cook.new, butler: Butler.new)
me.greet_people
me.serve_drinks
me.order_a_sandwich
puts
puts "*****"
puts
