class Question < ApplicationRecord
  belongs_to :theme

  has_many :posts, dependent: :nullify

  validates_presence_of :title, :start_time, :end_time

  def posts_with_username
    posts = []
    self.posts.order(up: :desc).each do |element|
      new_el = { username: element.user.username }
      posts.append( element.attributes.merge(new_el))
    end
    posts
  end
end
