class CreateAnswerQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :answer_questions do |t|
      t.references :question, foreign_key: true
      t.references :student, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
