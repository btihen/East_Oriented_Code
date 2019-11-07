
# Plugins & East Oriented

# https://avdi.codes/topic/methods-vs-messages/
# https://avdi.codes/topic/pluggable-selector/

# exploring different IO instantiations
# ui = Object.const_get('IO').new(1)  # file object 1 is standard out
# ui.puts 'Cat'
#
# ui=$stdout
# ui.puts 'Cat'
#
# ui=STDOUT
# ui.puts 'Cat'

# Exploration of just the timer 
SleepTimer = Struct.new(:notifier, :notify_method) do
  def start(minutes, notify_message)
    sleep minutes * 60
    notifier.send(notify_method, notify_message)
    # notifier.public_send(notify_method, notify_message)
  end
end
SleepTimer.new($stdout, :puts).start(0.1, "Woof")

# a self configuring stdout clock - with vairable time & message 
class TeaClock
  attr_accessor :ui
  attr_accessor :timer

  # pass the whole ui object to the timer, instead of a method object.
  def initialize(ui_klass='IO', run_method=:puts, init_info=1)
    self.ui    = Object.const_get(ui_klass).new(init_info)  # base method (super call this)
    self.timer = SleepTimer.new(ui, run_method)
    initialize_plugins 
  end

  # allows runtime dynamic plugin classes to be used
  def runtime_plugin(klass_name)
    @plugins << Object.const_get(klass_name).new(self)
    self       # enable Fluent API (East Orientation) - chaining
  end

  def start(minutes=0.1, message='Tea Time')
    timer.start(minutes, message)
    self     # enable Fluent API (East Orientation) - chaining
  end

  private

  # looks for any constants (class names) defined in the Plugin module namespace,
  def initialize_plugins
    @plugins = []
    # early return if ::Plugins const can't be found (avoids a crash)
    return self  unless Object.const_defined?('::Plugins')

    # collect class names (constants) in the Plugins Namespace
    ::Plugins.constants.each do |name|
      # initialize the plugin class(es) found
      @plugins << ::Plugins.const_get(name).new(self)
    end
    self   # enable Fluent API (East Orientation) - chaining
  end

end

# default configs work
t = TeaClock.new
t.start

# demo changeable times and message
TeaClock.new.start(0.1, "IO-Bark")

# demo self config works
TeaClock.new('IO', :puts).start(0.1, "Bark-Bark")
# IO-Bark

# add a really basic UI implementation, that plays nicely with $stdout
class StdioUi
  def initialize(_=nil)
  end
  def run(text)
    puts text  # calls the common interface
    self          # enable Fluent API (East Orientation) - chaining
  end
  def call(text)
    puts "PUTS - #{text}"  # calls the common interface
    self
  end
end

# home built Stdout class - works with no params
StdioUi.new.run 'hi'
# hi

# demo home built Stdout class - works / ignores given params
StdioUi.new(1).run 'hi'
# hi

# demo original behavior
TeaClock.new('StdioUi', :run).start(0.1, "Bark")
# Bark

# demo alterative call / config
TeaClock.new('StdioUi', :call).start(0.1, "Bark-Bark")
# PUTS - Bark-Bark

# Here’s are simple plugins to demo behavior and execution order
# It dynamically extends the ui object with a module that adds extra behavior to the notify method.
# The idea behind this plugin is that it will augment the StdioUi 
module Plugins

  class Beep
    def initialize(tea_clock)
      tea_clock.ui.extend(UiWithBeep)
    end
    module UiWithBeep
      def run(*)
        puts "BEEP!"
        super
        self     # allow chaining
      end
    end
  end

  class Alarm
    def initialize(tea_clock)
      tea_clock.ui.extend(UiWithAlarm)
    end
    module UiWithAlarm
      def run(*)
        puts "BEEP - Beeeeeep!"
        super
        self
      end
    end
  end

end

# demo original timer still flexible & can use stdout directly
SleepTimer.new($stdout, :puts).start(0.1, "Woof")
# Tea Time

# demo fancy teaclock with call configured doesn't use plugins
TeaClock.new('StdioUi', :call).start(0.1, "Bark-Bark")
# PUTS - Bark-Bark

# demo fancy teaclock with standard 'run' configured uses all the plugins
clock = TeaClock.new('StdioUi', :run).start(0.1, "Bark")
# BEEP!
# BEEP - Beeeeeep!
# Bark


# demo extend allows adding new module / methods on the fly
module UiWithBop
  def run(message, *)
    puts "<BOP> #{message}"
    super
    self
  end
end

# config clock with run (plugin api)
clock = TeaClock.new('StdioUi', :run).start(0.1, "Bark")
# dynamically add Bop (following plugin api)
clock.ui.extend(UiWithBop)
clock.start(0.2, "Beer Time")
# <BOP> Beer Time
# BEEP!
# BEEP - Beeeep!
# Beer Time

# demo usage of a method - not following plugin api (just a new behavior)
module UiExecute
  def execute(message)
    puts message
    self    # allows chaining
  end  
end  

# first extend, then 'execute' extension, then use the timer as planned with api plugins
TeaClock.new('StdioUi', :run).extend(UiExecute).execute("hi").start(0.05, 'Wow')
# hi 
# <BOP> Wow
# BEEP!
# BEEP - Beeeeeep!
# Wow

class Run
  def initialize(clock)
    clock.ui.extend(UiRun)
  end
  module UiRun
    def run(message, *)
      puts "<run> #{message}"
      super
      self
    end
  end
end  

# configure using standards for api (included in config remind)
clock = TeaClock.new('StdioUi', :run)

# demo adding the api compatible class on the fly
clock.runtime_plugin('Run')

# demo that the dynamically loaded plugin executes (in addition to the others)
clock.start(0.02, "Bed Time")
# <run> Bed Time
# <BOP> Bed Time
# BEEP!
# BEEP - Beeeeeep!
# Bed Time

# demo a new 'main class - that takes params
class StdioPuts
  def call(message)
    puts "<Call>"
    puts message
    self
  end  
end  
tea = TeaClock.new('StdioPuts', :call)
tea.start(0.05, 'Wow')
# <Call>
# Wow

# demo chaining in action
module UiNewLine
  def new_line
    puts ''
    self
  end  
end  

# extend allows adding new methods on the fly (without plugin capabilities)
clock = TeaClock.new.extend(UiNewLine)
clock.start(0.2, "Beer Time")
# Beer Time

# returning self allows chaining
clock.start(0.2, "Beer Time").new_line.start(0.2, "Bed Time")
# Beer Time
#
# Bed Time

# extend allows adding new methods on the fly (WITH plugin capabilities)
TeaClock.new('StdioUi', :run).start(0.1, "Bark")
# BEEP!
# BEEP - Beep!
# Bark

# DEMO returning self allows chaining
TeaClock.new('StdioUi', :run).extend(UiNewLine).start(0.2, "Beer Time").new_line.start(0.2, "Bed Time")
# BEEP!
# BEEP - Beep!
# Beer Time

# BEEP!
# BEEP - Beep!
# Bed Time
