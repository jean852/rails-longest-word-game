class GamesController < ApplicationController
  def new
    #generate new grid of 10 char
    @grid = []
    (1..10).each do
      @grid << rand(65..90).chr.to_s
    end
  end

  def score
    # on recup les parametre Attempt / Grid /
    @grid = []
    @grid = params[:grid]
  end




  def englishword(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    dictionary_serialized = URI.open(url).read
    JSON.parse(dictionary_serialized)
  end

  def run_game(attempt, grid, start_time, end_time)
    dictionary = englishword(attempt)
    if attempt.upcase!.chars.all? { |letter| grid.count(letter) >= attempt.count(letter) } == false
      message = "not in the grid"
      score = 0
    else
      dictionary["found"] ? score = (dictionary["word"].length / (end_time - start_time)) : score = 0
      dictionary["found"] ? message = "well done" : message = "not an english word"
    end
    { time: (end_time - start_time), score: score, message: message }
  end
end
