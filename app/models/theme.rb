class Theme < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :questions, dependent: :destroy
  has_one_attached :logo

  validates_presence_of :name

  def get_image_url
    url_for(logo) if logo.attached?
  end

  def get_questions_image
    questions.reduce([]) { |memo, question|  memo << question.get_question_image }
  end

  def get_theme_image
    attributes.merge(logo: get_image_url)
  end

  def update(attributes = {})
    if attributes[:logo]
      logo.purge if logo.attached?
    end
    super(attributes)
  end

  def update!(attributes = {})
    if attributes[:logo]
      logo.purge if logo.attached?
    end
    super(attributes)
  end
end
