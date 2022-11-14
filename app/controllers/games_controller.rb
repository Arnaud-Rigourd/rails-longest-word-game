require 'json'
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @answers = params[:guess].upcase
    @answers = @answers.split('')
    @letters = params[:letters].split(' ')

    url = "https://wagon-dictionary.herokuapp.com/#{@answers.join('')}"
    user_serialized = URI.open(url).read
    @user = JSON.parse(user_serialized)

    if @user['found']
      @answers.each do |answer|
        if @letters.include?(answer)
          index = @letters.find_index(answer)
          @letters.delete_at(index)
          @computeur_message = "You find a #{10 - @letters.length} letters word : #{@answers.join('')}"
        else
          @computeur_message = 'You used unexpected letter(s)'
        end
      end
    else
      @computeur_message = 'Sorry, your word is not an english one'
    end
  end
end
