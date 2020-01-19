require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'hangman'

game = Game.new

get '/' do
    if params["submit"] == "Guess!"
      unless game.win? || game.lose?
          game.check_guess(params["guess"]) if params["guess"]
      end
    end
    
    if params["submit"] == "Find a New Word"
      game = Game.new
    end  

    erb :index, :locals => { :guess_state => game.guess_state,
                             :guessed_letters => game.guessed_letters.join(', '),
                             :attempts_left => game.attempts_left,
                             :current_word => game.current_word,
                             :win => game.win?,
                             :lose => game.lose?
                          }
end