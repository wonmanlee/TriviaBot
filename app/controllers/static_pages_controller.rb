class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @leaderboard = User.fetch_leaderboard(10)
    
  end

  def leaderboard
  end
end
