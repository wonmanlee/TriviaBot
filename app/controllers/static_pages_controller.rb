class StaticPagesController < ApplicationController
  def home
    @categories = Question.all.pluck(:category_title).uniq
    
  end

  def leaderboard
  end
end
