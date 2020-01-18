require 'msgpack'

class Game
  attr_accessor :words, :current_word, :guess_state, :attempts_left, :end_game, :guessed_letters
  
  def initialize
    @words = dictionary
    @current_word = random_word
    @guess_state = initialize_string
    @attempts_left = 12
    @end_game = false
    @guessed_letters = []
  end

  #def start
  #  until end_game || attempts_left < 1
  #    play_round
  #  end
  #end

  def dictionary
    File.readlines('dictionary.txt')
  end

  def random_word
    words.select { |word| word.size > 5 && word.size <= 12 }.sample.strip.downcase
  end

  def initialize_string
    str = ""
    (current_word.size).times { str += "_" }
    str
  end

  def show_guess_state
    guess_state.gsub('', ' ').upcase
  end

  def check_guess(input)
    if current_word.include?(input)
      set_guessed_letters(input)
    else
      self.attempts_left -= 1
      guessed_letters << input
    end
  end

  def set_guessed_letters(input)
    guess_state.map.each_with_index { |letter, i| input == current_word[i] ? letter : "_" }
  end
end

hangman = Game.new
puts hangman.right_guess