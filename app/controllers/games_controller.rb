require 'open-uri'

class GamesController < ApplicationController
  VOWELS = ["A", "E", "I", "O", "U"]
  
  def score
    @score = 0
    @letters = params[:letters].split
    @word = (params[:word] || " ").upcase
    @include = is_in_it?(@word, @letters)
    @english = english?(@word)


  end
    
  def new
    @letters = ("A".."Z").to_a.sample(6)
    @letters += VOWELS.sample(4)
    @letters.shuffle!
  end
  


private

 def is_in_it?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

end