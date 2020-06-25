class Theme < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :questions, dependent: :destroy
  has_one_attached :logo

  validates_presence_of :name

  def get_image_url
    url_for(self.logo) if self.logo.attached?
  end

  def get_questions_image
    self.questions.reduce([]) do |memo, question|
      memo <<
          {
            :question => question.attributes,
            :image => question.get_image_url
          }
    end
  end

  def get_theme_image
    {
        :theme => self.attributes,
        :logo => get_image_url
    }
  end
end
