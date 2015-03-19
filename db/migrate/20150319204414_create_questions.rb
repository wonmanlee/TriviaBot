class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text    :answer
      t.text    :question
      t.integer :question_id
      t.integer :value
      t.string  :category_title
      t.integer :category_id
      t.date    :airdate
      t.boolean :random, default: false

      t.timestamps null: false
    end
  end
end
