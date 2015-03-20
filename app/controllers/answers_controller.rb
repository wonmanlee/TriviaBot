class AnswersController < ApplicationController
  def create
    # question = Question.find(params[:q_id])
  end

# <%= form_tag(question_answers_path, method: "POST") do %>
#   <input type="text" class="form-control" placeholder="Input your answer">
#   <%= submit_tag("Submit Answer") %>
# <% end %>
  def show
  end

private
  def answer_params
    params.require(:answer).permit(:type, :answer)
  end
end
