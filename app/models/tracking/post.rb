class Tracking::Post < ApplicationRecord
  self.table_name = 'tracking_posts'

  def self.get_collection
    Post.where("created_at > ?", 1.days.ago)
  end

  def self.get_most_publisher_user_id(collection)
    h = {}
    collection.pluck(:user_id).each { |id| h["#{id}"].nil? ? h["#{id}"] = 1 : h["#{id}"] += 1}
    h.max_by(&:last)[0]
  end

  def self.get_most_post_question_id(collection)
    h = {}
    collection.pluck(:question_id).each { |id| h["#{id}"].nil? ? h["#{id}"] = 1 : h["#{id}"] += 1}
    h.max_by(&:last)[0]
  end

  def self.get_most_up_post_id(collection)
    collection.pluck(:id, :up).max_by { |el| el[1] }[0]
  end
end