class UserInfo < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_and_belongs_to_many :achievements
  has_one_attached :profile_picture
  has_one_attached :banner

  validates_uniqueness_of :username
  validates_presence_of :username

  def get_image_url
    pp = url_for(self.profile_picture) if self.profile_picture.attached?
    banner = url_for(self.banner) if self.banner.attached?
    {
        profile_picture: pp,
        banner: banner
    }
  end

  def self.search(to_search)
    self.where("username LIKE ?", "%" + to_search + "%")
  end

  def get_achievements
    achievements.reduce([]) { |memo, acc| memo << acc.get_full_info }
  end
end
