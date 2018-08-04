require 'sinatra'
require 'sinatra/reloader' if development?

get '/guesser/' do
    load 'web_guesser.rb'
    redirect to '/guesser/new'
end

get '/caesar/' do
    load 'caesar_shifter.rb'
    redirect to '/caesar/new'
end

get '/mastermind/' do
    load 'mastermind.rb'
    redirect to '/mastermind/new'
end

get '/' do
    erb :home
end
