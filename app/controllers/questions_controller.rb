class QuestionsController < ApplicationController
  def index
    @questions = []
    qids = Question.all.pluck(:category_id).uniq.shuffle.first(20)
    qids.each do |qid|
      @questions << Question.where(category_id: qid).sample
    end
    @questions.sort! { |x, y| x.value <=> y.value }
  end

  def create
    if question_params["random"]
      q = Question.fetch_random_question
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
  end

private
  def question_params
    params.permit(:category_id, :random)
  end
end