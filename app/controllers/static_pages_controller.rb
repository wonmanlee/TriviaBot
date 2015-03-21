class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @top10 = User.fetch_leaderboard

    
  end

  def leaderboard
  end
end
