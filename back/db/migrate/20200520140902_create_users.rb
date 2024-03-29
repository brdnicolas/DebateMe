class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :email, unique: true
      t.boolean :isPremium, default: false
      t.boolean :isBan, default: false
      t.boolean :isAdmin, default: false

      t.timestamps
    end
  end
end
