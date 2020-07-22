class UserInfo < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_and_belongs_to_many :achievements
  has_one_attached :profile_picture

  validates_uniqueness_of :username
  validates_presence_of :username

  def get_image_url
    url_for(self.profile_picture) if self.profile_picture.attached?
  end

  def search(to_search)
    self.where("username LIKE ?", "%" + to_search + "%")
  end
end
