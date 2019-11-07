# Sandi Metz - Somethin is Nothing
# https://www.youtube.com/watch?v=OMPfEXIlTVE
# https://www.sandimetz.com/blog/2014/9/9/shape-at-the-bottom-of-all-things
class ChainTale

  def initialize(**args)
    @verse_intro   = args[:verse_intro]   || VERSE_INTRO
    @verse_closing = args[:verse_closing] || VERSE_CLOSE
    @verses_joiner = args[:verses_joiner] || VERSES_JOINER
    @phrase_joiner = args[:phrase_joiner] || PHRASE_JOINER
    @phrases       = Array(args[:phrases] || PHRASES)
  end

  def recite_tale
    recite_verses(phrases.length)
  end

  def recite_verses(number)
    (1..number).map {|i| "VERSE: #{i}\n#{recite_verse(i)}"}.
                        join(verses_joiner)
  end

  def recite_verse(number)
    "#{verse_intro}#{get_phrases(number)}#{verse_closing}"
  end

  private
  attr_reader :phrases, :phrase_joiner, :verse_intro, :verse_closing, :verses_joiner

  def get_phrases(number)
    phrases.last(number).join(phrase_joiner)
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

puts "\n----\n" + ChainTale.new.recite_tale + "\n----\n"
