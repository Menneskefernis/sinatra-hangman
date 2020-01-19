class Game
  attr_accessor :words, :current_word, :guess_state, :attempts_left, :end_game, :guessed_letters
  
  def initialize
    @words = dictionary
    @current_word = random_word
    @guess_state = initialize_string
    @attempts_left = 10
    @end_game = false
    @guessed_letters = []
  end

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
      guessed_letters << input.upcase unless guessed_letters.include? input.upcase
    end
  end

  def set_guessed_letters(input)
    positions = (0 ... current_word.length).find_all { |i| current_word[i] == input }

    positions.each do |pos|
      guess_state[pos] = input.upcase
    end
  end

  def win?
    if guess_state.include? "_"
      return false
    else
      return true
    end
  end

  def lose?
    if attempts_left < 1
      return true
    else
      return false
    end
  end
end