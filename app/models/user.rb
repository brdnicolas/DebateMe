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

  def check_anonym
    if posts.pluck(:isAnonym).uniq.include? true
      user_info.achievements << Achievement.find_by_name('Homme mystère')
    end
  end

  def check_validate
    if user_info.attributes.key(nil).nil?
      Achievement.find_or_create_by(user_info_id: user_info.id, achievement_id: Achievement.find_by_name('Validé').id, progression: 100)
    end
  end

  def check_first_step
    if post_ids.size > 0
      Achievement.find_or_create_by(user_info_id: user_info.id, achievement_id: Achievement.find_by_name('Premier pas').id, progression: 100)
    end
  end

  def check_influenceur
    posts.reduce(0) { |memo, post| memo + post.childpost.count }
    Achievement.find_or_create_by(user_info_id: user_info.id, achievement_id: Achievement.find_by_name('Influenceur').id, progression: 100)
  end

  def check_symphatique
    posts.pluck(:up).count
  end



end