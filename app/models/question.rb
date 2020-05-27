class Question < ApplicationRecord
  belongs_to :theme

  has_many :posts, dependent: :nullify

  validates_presence_of :title, :start_time, :end_time

  def posts_parsed
    posts = []
    self.posts.order(up: :desc).each do |element|
      new_el = { user: element.user, post: element, votes_id: element.get_vote_ids }
      posts.append(new_el)
    end
    posts
  end
end
