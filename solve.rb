require "pry"

class SpellingBee
  class << self
    def run!(**options)
      new(**options).run!
    end
  end

  def initialize(required:, optional:, min_letter_count:)
    @required_letter = required
    @optional_letters = optional
    @min_letter_count = min_letter_count
    @all_letters = optional + [required]
  end

  def get_dictionary
    path = "./words_en.txt"
    File.open(path, "r")
  end

  def run!
    get_dictionary.map(&:strip).select { |word|
      /^([#{@all_letters}]{#{@min_letter_count},})$/.match(word) && /#{@required_letter}+/.match(word) && !/^[A-Z]/.match(word)
    }
  end
end

puts SpellingBee.run!(required: "k", optional: %w(c t r i e y), min_letter_count: 5)
