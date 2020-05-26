class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.boolean :isAnonym, default: false
      t.integer :up, default: 0
      t.integer :down, default: 0
      t.references(:user, null: false, type: :bigint)
      t.references :subpost
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
