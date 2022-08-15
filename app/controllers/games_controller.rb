require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @score = params['score']
    @letters = params['letters']
    url = "https://wagon-dictionary.herokuapp.com/#{@score}"
    @wordexist = JSON.parse(URI.open(url).read)
    if @score.split(//).any? { |s| @letters.exclude? s }
      @result = "Sorry but #{@score} can't be built out of #{@letters}"
    elsif @wordexist["found"] == true
      @result = "Congratulation! #{score} is a valid English word!"
    else
      @result = "Sorry but #{@score} does not seem to be a valid English word"
    end
  end
end
