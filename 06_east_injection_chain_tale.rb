require 'pry'
require './05_east_injection_tale'

# Sandi Metz - Somethin is Nothing
# https://www.youtube.com/watch?v=OMPfEXIlTVE
# https://www.sandimetz.com/blog/2014/9/9/shape-at-the-bottom-of-all-things

class VerseTextTemplate
  def recite_tale(tale)
    recite_verses(tale, tale.phrases.count)
    self
  end
  def recite_verses(tale, number)
    puts (1..number).map {|i| "VERSE: #{i}\n#{build_verse(tale, i)}"}.
                     join(tale.verses_joiner)
    self
  end
  def recite_verse(tale, number)
    puts "VERSE: #{number}\n#{build_verse(tale, number)}"
    self
  end
  private
  attr_reader :phrases, :phrase_joiner, :verses_joiner, :verse_intro, :verse_closing
  def build_phrase(tale, number)
    tale.phrases.last(number).join(tale.phrase_joiner)
  end
  def build_verse(tale, number)
    "#{tale.verse_intro}#{build_phrase(tale, number)}#{tale.verse_closing}"
  end
end

class EastTale
  def initialize(**args)
    @phrases       = args[:phrases]       || PHRASES
    @phrase_joiner = args[:phrase_joiner] || PHRASE_JOINER
    @verses_joiner = args[:verses_joiner] || VERSES_JOINER
    @verse_intro   = args[:verse_intro]   || VERSE_INTRO
    @verse_closing = args[:verse_closing] || VERSE_CLOSE
  end
  def recite_tale(template: VerseTextTemplate.new)
    template.recite_tale(tail_values)
    self
  end
  def recite_verses(number, template: VerseTextTemplate.new)
    template.recite_verses(tail_values, number)
    self
  end
  def recite_verse(number, template: VerseTextTemplate.new)
    template.recite_verse(tail_values, number)
    self
  end
  private
  attr_reader :phrases, :phrase_joiner, :verses_joiner, :verse_intro, :verse_closing
  # create a value object
  require 'ostruct'
  def tail_values
    OpenStruct.new(phrases: phrases, phrase_joiner: phrase_joiner,
                   verses_joiner: verses_joiner,
                   verse_intro: verse_intro, verse_closing: verse_closing)
  end
end

# open/closed using composition/injection
class InjectedEastTale < EastTale
  def initialize(**args)
    order   = args.delete(:order)  || Order::Default
    effect  = args.delete(:effect) || Effect::Default

    phrases        = args[:phrases] || PHRASES
    recite_order   = order.call(phrases)
    args[:phrases] = effect.call(recite_order)

    super(args)
  end
end


InjectedEastTale.new.recite_tale

puts "*" * 10

InjectedEastTale.new.recite_tale

puts "#" * 30

InjectedEastTale.new(order: Order::Random).recite_tale

puts "#" * 30

InjectedEastTale.new(effect: Effect::Echo).recite_tale

puts "#" * 30

InjectedEastTale.new( order: Order::Random,
                      effect: Effect::Echo ).recite_tale

puts "#" * 30

InjectedEastTale.new( order: Order.new('random'),
                      effect: Effect.new('echo') ).recite_tale



# EasternTale.new.recite_verses(2)
#
# puts "*" * 10
# EasternTale.new.recite_verse(3)
#
# puts "*" * 10
# puts "*" * 10
# tale = EasternTale.new
# tale.recite_verses(4).recite_verse(5)
