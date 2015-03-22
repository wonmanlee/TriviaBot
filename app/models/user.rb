class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :answers
  has_many :questions, through: :answers

  def self.fetch_leaderboard(number=10)
    leaderboard = {}
    User.all.each do |u|
      leaderboard["#{u.username}"] = u.total_score
    end
    leaderboard.sort { |x, y| y[1] <=> x[1] }.first(number)
  end

  def answer_question q_id
    self.answers.where(question_id: q_id).first_or_create!
  end

  def answered?(q_id)
    self.answers.pluck(:question_id).include?(q_id.to_i)
  end

  def total_score
    total_score = 0
    correct_answers.each do |q|
      total_score += Question.find(q).value
    end
    wrong_answers.each do |q|
      total_score -= Question.find(q).value
    end
    total_score
  end

  def correct_answers
    self.answers.where(correct: true).pluck(:question_id)
  end

  def wrong_answers
    self.answers.where(correct: false).pluck(:question_id)
  end

  # TODO tally random scores ~500 pts
end
