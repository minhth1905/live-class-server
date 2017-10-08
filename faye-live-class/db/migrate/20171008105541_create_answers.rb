class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :content
      t.integer :marker_id
      t.string :full_name

      t.timestamps
    end
  end
end
