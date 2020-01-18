require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'hangman'

game = Game.new

configure do
  enable :sessions
  set :session_secret, "something"
end

get '/' do
  game.check_guess(params["guess"]) if params["guess"]
  #throw params.inspect
  erb :index, :locals => { :guess_state => game.guess_state,
                           :guessed_letters => game.guessed_letters,
                           :attempts_left => game.attempts_left,
                           :current_word => game.current_word
                        }
end