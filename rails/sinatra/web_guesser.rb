require 'sinatra'
require 'sinatra/reloader' if development?
require 'chroma'

@@number
@@guesses_left

get '/guesser/new' do
    @@number = rand(100)
    @@guesses_left = 5
    erb :web_guesser, :locals => {
        data: {
            :number => @@number,
            :guess => nil,
            :guesses_left => @@guesses_left
        }
    }
end

post '/guesser/' do
    guess = params['guess'].to_i
    @@guesses_left -= 1
    erb :web_guesser, :locals => {
        data: {
            :number => @@number,
            :guess => guess,
            :guesses_left => @@guesses_left,
            :analysis => analyse_guess(guess, @@number),
            :color => color_diff(guess, @@number),
            :cheat => params['cheat'] == 'true'
        }
    }
end

def analyse_guess(guess, number)
    if guess > number + 20
        'Way too high'
    elsif guess > number
        'Too high'
    elsif guess < number - 20
        'Way too low'
    elsif guess < number
        'Too low'
    elsif guess == number
        'CORRECT!'
    end
end

def color_diff(guess, number)
    # 0 diff => 0,255,0 green hue = 60
    # 100 diff => 255,0,0 red hue = 0
    diff = (guess - number).abs
    # color scale gem
    "hsv(#{80 - diff * 0.8}, 1, 0.75)".paint.to_hex
end
