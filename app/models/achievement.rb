class Achievement < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :badge
  has_and_belongs_to_many :user_infos

  def get_image_url
    url_for(self.badge) if self.badge.attached?
  end

end
