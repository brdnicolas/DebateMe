class Question < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :image

  has_many :posts, dependent: :destroy
  belongs_to :theme

  validates_presence_of :title, :start_time
  validates :start_time, format: { with: /\d{4}-\d{2}-\d{2}/, message: 'Date Format invalid' }
  validates :end_time, format: { with: /\d{4}-\d{2}-\d{2}/, message: 'Date Format invalid' }

  def get_image_url
    url_for(image) if image.attached?
  end

  def update(attributes = {})
    image.purge if attributes[:image] && image.attached?
    super(attributes)
  end

  def update!(attributes = {})
    image.purge if attributes[:image] && image.attached?
    super(attributes)
  end

  def posts_parsed
    posts.order(up: :desc)
         .reduce([]) { |memo, acc| memo << { user: acc.user.full_info, post: acc, votes_id: acc.get_vote_ids } }
  end

  def get_question_image
    attributes.merge(image: get_image_url)
  end

end
