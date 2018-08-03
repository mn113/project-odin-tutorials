require 'sinatra'
require 'sinatra/reloader'
require 'chroma'

prng = Random.new
number = 0

get '/newnumber' do
    number = prng.rand(100) + 1     # generates 0-99
    erb :index, :locals => {
        data: {
            :number => number,
            :guess => nil
        }
    }
end

get '/guess/' do
    guess = params['guess'].to_i
    erb :index, :locals => {
        data: {
            :number => number,
            :guess => guess,
            :analysis => analyse_guess(guess, number),
            :color => color_diff(guess, number)
        }
    }
end

def analyse_guess(guess, number)
    if guess > number + 20
        'Way too high'
    elsif guess > number
        'Too high'
    elsif guess < number
        'Too low'
    elsif guess < number - 20
        'Way too low'
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
