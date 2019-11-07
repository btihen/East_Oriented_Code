
# EXAMPLE TWO #
###############
class Person 
	attr_reader :cook
	def make_me_a_sandwich 
		cook.make_me_a_sandwich
	end
end
class Cook 
	def make_me_a_sandwich 
		puts "a sandwich"
		self
	end
end

# add forwardable - better than defining twice
# but then its actually its a query now
class Person 
	extend Forwardable
	delegate :make_a_sandwich => :cook
	attr_reader :cook
end
class Cook 
	def make_a_sandwich 
		puts "a sandwich"
		self
	end
end

# look at gem direction - to force commands not queries!
class Person 
	extend Eastward
	command :make_a_sandwich => :cook
	# with multiple methods
	command [:greet_people, :serve_drinks] => :butler
	private
	attr_reader :butler
end
class Cook 
	def make_a_sandwich 
		puts "a sandwich"
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

# gem direction is very simple 
# give command a hash, keys are the methods, values are accessors to operate on
module Eastward 
	def command(options)
		method_defs = []
		# loop through hash of methods and objects to operate on (butler in above case)
		options.each_pair do |key, value|
			Array(key).map do |command_name|
				method_defs.unshift %{
					def #{command_name}(*args. &block)
						#{value}.__send__(:#{command_name}, *args, &block)
						self
					end
				}
			end
		end
		self.class_eval method_defs.join(' ') # actually executes code built above
	end
end

