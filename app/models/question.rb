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

  def self.fetch_random_question(count = 1)
    request = get("/api/random?count=#{count}").first
    clue = Question.where(question_id: request["id"]).first_or_create! do |q|
      q.answer          = request["answer"]
      q.question        = request["question"]
      q.question_id     = request["id"]
      q.value           = request["value"] || 500
      q.category_title  = request["category"]["title"]
      q.category_id     = request["category"]["id"]
      q.airdate         = request["airdate"].first(10)
    end
    clue
  end

end
