class CreateAchievements < ActiveRecord::Migration[6.0]
  def change
    create_table :achievements do |t|
      t.string :name
      t.string :description
      t.string :goal

      t.index :name
      t.timestamps
    end
  end
end
