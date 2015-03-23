class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home

  end

  def leaderboard
    @users = User.page(params[:page])
  end
end
