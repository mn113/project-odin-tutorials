require 'sinatra'
require 'sinatra/reloader' if development?

get '/:s?' do |s|
    offset = s ? s.to_i : 0
    # erb :index, :locals => {
    #     data: {
    #         :text => nil,
    #         :offset => nil
    #     }
    # }
    #caesar("the quick brown fox jumps over a lazy dog.", offset)
    #caesar("abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ", 3)
    caesar("the quick brown fox jumps over a lazy dog.".upcase, offset)
end

def caesar(text, offset)
    text.chars.map{ |c|
        if (65..91).include?(c.ord) # UPPERCASE
            d = c.ord + offset
            d -= 26 if d >= 91
            d += 26 if d < 65
            d.chr
        elsif (97..123).include?(c.ord) # lowercase
            d = c.ord + offset
            d -= 26 if d >= 123
            d += 26 if d < 97
            d.chr
        else # non-letter
            c
        end
    }.join
end
