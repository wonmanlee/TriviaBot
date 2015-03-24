class Question < ActiveRecord::Base
  include HTTParty
  base_uri "http://jservice.io"
  format :json

  has_many :answers
  has_many :users, through: :answers

  validates :question_id, uniqueness: true
  validates_presence_of :value

  # 'popular' categories
  CATEGORIES = [306, 1, 136, 42, 780, 21, 105, 25, 7, 103, 442, 67, 109, 227, 114, 31, 176, 582, 508, 49, 561, 1114, 223, 770, 622, 313, 420, 253, 83, 184, 211, 51, 539, 267, 357, 530, 793, 369, 777, 672, 78, 574, 680, 50, 99, 309, 41, 249, 26, 218, 1420, 1145, 1079, 37, 89, 139, 197, 17, 897, 1800, 705, 1195, 128, 2537]

  def self.generate_board(user_id)
    questions = []
    answered = User.find(user_id).answered
    qids = Question.all.pluck(:category_id).uniq
    while questions.count < 20
      q = Question.where(category_id: qids.sample).sample 
      questions << q unless answered.include?(q.id)
    end
    questions.sort! { |x, y| x.value <=> y.value }
  end

  def self.cache_questions_by_category(category_id=nil)
    category_id = CATEGORIES.sample if category_id.nil?
    request = get("/api/category?id=#{category_id}")
    request["clues"].each do |clue|
      Question.where(question_id: clue["id"]).first_or_create! do |q|
        q.answer          = clue["answer"]
        q.question        = clue["question"]
        q.question_id     = clue["id"]
        q.value           = clue["value"] || 500
        q.category_title  = request["title"]
        q.category_id     = request["id"]
        q.airdate         = clue["airdate"].first(10)
      end
    end
  end

  def self.cache_random_question(count = 1)
    request = get("/api/random?count=#{count}")
    request.each do |r|
      Question.where(question_id: r["id"]).first_or_create! do |q|
        q.answer          = r["answer"]
        q.question        = r["question"]
        q.question_id     = r["id"]
        q.value           = r["value"] || 500
        q.category_title  = r["category"]["title"]
        q.category_id     = r["category"]["id"]
        q.airdate         = r["airdate"].first(10)
      end
    end
  end

  def self.remove_html_from_answers
    questions = Question.where("answer LIKE (?)", "%<i>%")
    questions.each do |q|
      q.update(answer: q.answer.gsub("<i>", ""))
      q.update(answer: q.answer.gsub!("</i>", ""))
    end
  end
end
