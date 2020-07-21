class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :user_has_votes, dependent: :nullify
  has_many :reports, dependent: :destroy
  has_one :user_info, dependent: :destroy

  validates_presence_of :password_digest, :email
  validates_uniqueness_of :email, case_sensitive: true

  def full_info
    attributes.merge(user_info&.attributes || {}).merge(profile_pic: user_info&.get_image_url)
  end

  def self.all_full_info
    User.all.reduce([]) { |memo, acc| memo << acc.full_info }
  end
end