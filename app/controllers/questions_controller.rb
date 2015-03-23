class QuestionsController < ApplicationController
  def index
    @questions = Question.generate_board(current_user.id)
  end

  def create
    if question_params["random"]
      q = Question.cache_random_question
      redirect_to q
    elsif question_params["category_id"]
      q = Question.where(category_id: question_params["category_id"]).sample
      redirect_to to q
    end
  end

  def show
    q = Question.find(params[:id])
    @question = q.question
    @value = q.value
    @category_title = q.category_title
    @airdate = q.airdate
  end

private
  def question_params
    params.permit(:category_id, :random)
  end
end