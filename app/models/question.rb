class Question < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :image

  belongs_to :theme
  has_many :posts, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates_presence_of :title, :start_time, :end_time

  def get_image_url
    url_for(self.image) if self.image.attached?
  end

  def posts_parsed
    posts = []
    self.posts.order(up: :desc).each do |element|
      new_el = { user: element.user, post: element, votes_id: element.get_vote_ids }
      posts.append(new_el)
    end
    posts
  end

  def get_question_image
    attributes = self.attributes
    attributes[:image] = get_image_url
    attributes
  end

end
