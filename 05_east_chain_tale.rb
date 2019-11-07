require 'pry'

# Lyrics Fetch Order (apply first)
module Order
  def self.new(choice)
    const_get( (choice || 'default').to_s.capitalize )
  end
  module Default
    def self.call(phrases)
      return phrases
    end
  end
  module Random
    def self.call(phrases)
      return phrases.shuffle
    end
  end
end
# Lyrics Effects (apply second)
module Effect
  def self.new(choice)
    const_get( (choice || 'default').to_s.capitalize )
  end
  module Default
    def self.call(phrases)
      return phrases
    end
  end
  module Echo
    def self.call(phrases)
      return phrases.zip(phrases).flatten
    end
  end
end

# open/closed using composition/injection
class InjectedTale < ChainTale
  def initialize(**args)
    super
    order     = args[:order]  || Order::Default
    effect    = args[:effect] || Effect::Default
    new_order = order.call(@phrases)
    @phrases  = effect.call(new_order)
  end
end

VERSE_CLOSE   = "."
VERSE_INTRO   = "This is "
VERSES_JOINER = "\n\n"
PHRASE_JOINER = ",\n        "
PHRASES  = [
  'the horse and the hound and the horn that belonged to',
  'the farmer sowing his corn that kept',
  'the rooster that crowed in the morn that woke',
  'the priest all shaven and shorn that married',
  'the man all tattered and torn that kissed',
  'the maiden all forlorn that milked',
  'the cow with the crumpled horn that tossed',
  'the dog that worried',
  'the cat that killed',
  'the rat that ate',
  'the malt that lay in',
  'the house that Jack built',
]

puts "\n----\n" + InjectedTale.new.recite_tale + "\n----\n"

puts "\n----\n" + InjectedTale.new(order: Order::Random).
                               recite_tale + "\n----\n"

puts "\n----\n" + InjectedTale.new(effect: Effect::Echo).
                               recite_tale + "\n----\n"

puts "\n----\n" + InjectedTale.new(order: Order::Random,
                                   effect: Effect::Echo).
                               recite_tale + "\n----\n"

puts "\n----\n" + InjectedTale.new(order: Order.new('random')).
                               recite_tale + "\n----\n"

puts "\n----\n" + InjectedTale.new( order: Order.new('random'),
                                    effect: Effect.new('echo') ).
                               recite_tale + "\n----\n"
