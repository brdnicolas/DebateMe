class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :user_has_votes, dependent: :nullify
  has_many :reports, dependent: :destroy
  has_one :user_info, dependent: :destroy

  validates_presence_of :password_digest, :email
  validates_uniqueness_of :email, case_sensitive: true

  def full_info
    user_info.attributes.merge(profile_picture: user_info.get_image_url)
  end

  def self.all_full_info
    User.all.reduce([]) { |memo, acc| memo << acc.full_info }
  end

  def check_achievements

  end

  private


  def check_anonym
    if posts.pluck(:isAnonym).uniq.include? true
      user_info.achievements
    end
  end

  def check_validate
    user_info.attributes.key(nil).nil?
  end

  def check_first_step
    post_ids.size > 0
  end

  def check_sympatique
    posts.reduce(0) { |memo, post| memo + post.childpost.count }
  end



end