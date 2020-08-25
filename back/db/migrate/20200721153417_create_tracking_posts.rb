class CreateTrackingPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :tracking_posts do |t|
      t.bigint :new_posts
      t.bigint :most_publisher_user_id
      t.bigint :most_up_post_id
      t.bigint :most_posts_question_id
      t.timestamps
    end
  end
end
