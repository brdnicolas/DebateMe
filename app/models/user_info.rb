class UserInfo < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_and_belongs_to_many :achievements
  has_one_attached :profile_picture
  has_one_attached :banner

  validates_uniqueness_of :username
  validates_presence_of :username

  def get_image_url
    pp = url_for(profile_picture) if profile_picture.attached?
    ban = url_for(banner) if banner.attached?
    {
      profile_picture: pp,
      banner: ban
    }
  end

  def update(attributes = {})
      if attributes[:profile_picture]
        profile_picture.purge if profile_picture.attached?
      end
      if attributes[:banner]
        banner.purge if banner.attached?
      end
      super(attributes)
    end
  end

  def self.search(to_search)
    where("username LIKE ?", "%" + to_search + "%")
  end

  def get_achievements
    achievements.reduce([]) { |memo, acc| memo << acc.get_full_info }
  end
end
