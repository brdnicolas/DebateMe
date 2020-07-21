class CreateUserInfoAchievementJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :achievements, :user_infos do |t|
      t.index :achievement_id
      t.index :user_info_id
      t.integer :progression, default: 0
    end
  end
end
