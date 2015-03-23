class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    
  end

  def leaderboard
    User.find_each do |u|
      u.update(score: u.total_score)
    end
    @users = User.order(score: :desc).page(params[:page])
  end
end
