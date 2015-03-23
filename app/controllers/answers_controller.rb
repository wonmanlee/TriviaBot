class AnswersController < ApplicationController
  def create
    if current_user.answered?(params[:question_id])
      flash["alert"] = "Error. You've already answered this question."
    else
      q = Question.find(params[:question_id])
      # TODO fix answer handling, threshold is 3
      if Levenshtein.distance(params["answer"].downcase, q.answer.downcase) <= 3
        flash["success"] = "Correct. The answer was '#{q.answer}'. You gained #{q.value} points."
        a = current_user.answers.create(question_id: q.id, correct: true)
      else
        flash["error"] = "Incorrect. The answer was '#{q.answer}'. You lost #{q.value} points."
        a = current_user.answers.create(question_id: q.id, correct: false)
      end
    end
    redirect_to questions_path
  end

private
  def answer_params
    params.require(:answer).permit(:type, :answer, :question_id)
  end
end
