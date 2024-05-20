require 'uri'
require 'net/http'

class GamesController < ApplicationController

  def new
    str = (0...10).map { (65 + rand(26)).chr }.join
    @letters = str.chars
  end

  def score
    @characters = params[:letters]
    user_input = params[:word].upcase
    @input = params[:word].chars

    a = 1

    user_input.chars.each do |letter|
      if @characters.include?(letter) == false
        a = 0
      end
    end

    # https://dictionary.lewagon.com/word

    uri = URI("https://dictionary.lewagon.com/#{user_input.downcase}")
    res = Net::HTTP.get_response(uri)
    hash = res.body if res.is_a?(Net::HTTPSuccess)

    @boolean = hash[9, 4]

    @result = "is a valid english word !" if (@boolean == 'true') && (a == 1)
    @result = 'is not valid' if @boolean != 'true'

  end
end
