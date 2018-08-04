require 'sinatra'
require 'sinatra/reloader' if development?

class Secret
    attr_reader :value

    def initialize()
        @value = []
        4.times do
            @value << Colours.keys[rand(Colours.keys.size)]
        end
        puts @value
    end
end

$Colours = {
    :red => '❤️',
    :orange => '🧡',
    :yellow => '💛',
    :green => '💚',
    :blue => '💙',
    :purple => '💜'
}

get '/new' do   # new game route
    $secret = Secret.new
    $history = []
    erb :mastermind
end

get '/' do      # refresh page route
    erb :mastermind
end

post '/' do     # make a guess route
    # extract params
    guess = 'col1.col2.col3.col4'.split('.').map{ |key| params[key].to_sym }
    puts guess
    $history << {
        :guess => guess,
        :score => analyse(guess.clone)
    }
    erb :mastermind
end

def analyse(pegs)
    score = []
    tempsecret = $secret.value.clone
    # extract blacks
    pegs.each_with_index do |peg, i|
        if peg == tempsecret[i]
            tempsecret[i] = false
            pegs[i] = nil
            score << :black
        end
    end
    # extract whites
    pegs.each_with_index do |peg, i|
        if tempsecret.include?(peg)
            found = tempsecret.find_index(peg)
            tempsecret[found] = false
            pegs[i] = nil
            score << :white
        end
    end
    score
end