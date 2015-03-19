class Answers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :user, index: true
      t.belongs_to :question, index: true

      t.timestamps null: false
    end
    add_foreign_key :answers, :users
    add_foreign_key :answers, :questions
  end
end
