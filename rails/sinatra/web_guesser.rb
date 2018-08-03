require 'sinatra'

prng = Random.new
number = 0

get '/newnumber' do
    number = prng.rand(100) + 1     # generates 0-99
    "Guess the number (1-100) I'm thinking of!"
end

post '/guess/:guess' do
    if guess > number + 20
        return 'Ho Lee Fuk'
    elsif guess > number
        return '2H'
    elsif guess < number
        return '2L'
    elsif guess < number - 20
        return 'Wi Tu Lo'
    elsif guess == number
        return 'Correct'
    end
end

