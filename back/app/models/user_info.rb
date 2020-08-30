class UserInfo < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_and_belongs_to_many :achievements
  has_one_attached :profile_picture
  has_one_attached :banner

  validates_uniqueness_of :username
  validates_presence_of :username

  def get_image_url
    profile_pic = url_for(profile_picture) if profile_picture.attached?
    banner_pic = url_for(banner) if banner.attached?
    { profile_picture: profile_pic, banner: banner_pic }
  end

  def update(attributes = {})
    image.purge if attributes[:profile_picture] && profile_picture.attached?
    image.purge if attributes[:banner] && banner.attached?
    super(attributes)
  end

  def update!(attributes = {})
    image.purge if attributes[:profile_picture] && profile_picture.attached?
    image.purge if attributes[:banner] && banner.attached?
    super(attributes)
  end

  def self.search(to_search)
    where('username LIKE ?', '%' + to_search + '%').map { |user_info| user_info.user.complete_profile }
  end

  def get_achievements
    achievements.reduce([]) { |memo, acc| memo << acc.get_full_info }
  end
end
