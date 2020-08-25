class CreateUserInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :user_infos do |t|
      t.string :username, unique: true
      t.string :firstname
      t.string :lastname
      t.text :quote
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
