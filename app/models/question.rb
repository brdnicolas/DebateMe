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
    if attributes[:image]
      image.purge if image.attached?
    end
    super(attributes)
  end

  def update!(attributes = {})
    if attributes[:image]
      image.purge if image.attached?
    end
    super(attributes)
  end

  def posts_parsed
    new_posts = []
    posts.order(up: :desc).each do |element|
      new_el = { user: element.user.full_info, post: element, votes_id: element.get_vote_ids }
      new_posts.append(new_el)
    end
    new_posts
  end

  def get_question_image
    attributes.merge(image: get_image_url)
  end


end
