require 'sinatra'
require 'sinatra/reloader'


prng = Random.new
number = 0

get '/newnumber' do
    number = prng.rand(100) + 1     # generates 0-99
    erb :index, :locals => {:number => number}
end

post '/guess/:guess' do
    if params['guess'] > number + 20
        return 'Ho Lee Fuk'
    elsif params['guess'] > number
        return 'Hi'
    elsif params['guess'] < number
        return 'Lo'
    elsif params['guess'] < number - 20
        return 'Wi Tu Lo'
    elsif params['guess'] == number
        return 'Correct'
    end
end

