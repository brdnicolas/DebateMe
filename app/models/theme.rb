class Theme < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_many :questions, dependent: :destroy
  has_one_attached :logo

  validates_presence_of :name

  def get_image_url
    url_for(self.logo)
  end
end
