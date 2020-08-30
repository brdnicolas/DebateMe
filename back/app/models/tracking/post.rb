class Tracking::Post < ApplicationRecord
  self.table_name = 'tracking_posts'

  def self.get_collection
    # Collect all recent posts
    Post.where('created_at > ?', 1.days.ago)
  end

  def self.get_most_publisher_user_id(collection)
    # Collect the oosts and look for the user that publish the most this day
    h = {}
    collection.pluck(:user_id).each { |id| h[id.to_s].nil? ? h[id.to_s] = 1 : h[id.to_s] += 1 }
    h.max_by(&:last)[0]
  end

  def self.get_most_post_question_id(collection)
    # Collect the oosts and look for posts with the most answered
    h = {}
    collection.pluck(:question_id).each { |id| h[id.to_s].nil? ? h[id.to_s] = 1 : h[id.to_s] += 1 }
    h.max_by(&:last)[0]
  end

  def self.get_most_up_post_id(collection)
    # Sorting by number of up then take the id
    collection.pluck(:id, :up).max_by { |el| el[1] }[0]
  end
end