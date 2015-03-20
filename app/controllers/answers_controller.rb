class AnswersController < ApplicationController
  def create
    q = Question.find(params[:question_id])
    if params["answer"] == q.answer
      a = current_user.answers.create(question_id: q.id, correct: true)
    else
      a = current_user.answers.create(question_id: q.id, correct: false)
    end
    redirect_to question_answer_path(q, a)
  end

  def show
    if current_user.answers.pluck(:question_id).include?(params[:id].to_i)
      @q = Question.find(params[:question_id])
      @score = current_user.total_score
    else
      flash[:warning] = "You do not have permission to view this page."
      # redirect_to home
    end
  end

private
  def answer_params
    params.require(:answer).permit(:type, :answer)
  end
end
