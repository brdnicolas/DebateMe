class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :documentation
      t.datetime :start_time
      t.datetime :end_time
      t.references :theme, null: false, foreign_key: true

      t.timestamps
    end
  end
end
