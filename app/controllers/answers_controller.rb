class AnswersController < ApplicationController
  def index
  end

  def create
    question = Question.find(params[:q_id])
  end

  def show
  end
end
