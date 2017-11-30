class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :id_mongo
      t.string :answer
      t.references :exam, foreign_key: true

      t.timestamps
    end
  end
end
