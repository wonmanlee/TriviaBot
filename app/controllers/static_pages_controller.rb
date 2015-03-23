class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @categories = Question.pluck(:category_title).uniq.shuffle.first(16)
  end

  def leaderboard
    User.find_each do |u|
      u.update(score: u.total_score)
    end
    User.order(score: :desc).page(params[:page])
  end
end
