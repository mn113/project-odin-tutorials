require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
    erb :caesar_shifter
end

post '/' do
    @offset = params['offset'].to_i
    @text = caesar(params['text'], @offset)
    erb :caesar_shifter
end

def caesar(text, offset)
    text.chars.map{ |c|
        if (65..91).include?(c.ord) # UPPERCASE
            d = c.ord + offset
            d -= 26 while d >= 91
            d += 26 while d < 65
            d.chr
        elsif (97..123).include?(c.ord) # lowercase
            d = c.ord + offset
            d -= 26 while d >= 123
            d += 26 while d < 97
            d.chr
        else # non-letter
            c
        end
    }.join
end
