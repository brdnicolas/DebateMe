namespace :statistics do
  desc "Calculate number of posts"
  task posts: :environment do
    today_posts = Tracking::Post.get_collection
    Tracking::Post.create( new_posts: today_posts.size,
                           most_publisher_user_id: Tracking::Post.get_most_publisher_user_id(today_posts),
                           most_posts_question_id: Tracking::Post.get_most_post_question_id(today_posts),
                           most_up_post_id: Tracking::Post.get_most_up_post_id(today_posts)
    )
  end
end
