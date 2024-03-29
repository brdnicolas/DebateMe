class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :user_has_votes, dependent: :nullify
  has_many :reports, dependent: :destroy
  has_one :user_info, dependent: :destroy

  validates_presence_of :password_digest, :email
  validates_uniqueness_of :email, case_sensitive: true

  def full_info
    user_info.attributes.merge(img: user_info.get_image_url, isPremium: user_info.user.isPremium)
  end

  def self.all_full_info
    User.all.reduce([]) { |memo, acc| memo << acc.full_info }
  end

  def complete_profile
    h = { username: user_info.username, quote: user_info.quote, img: user_info.get_image_url, user_id: id }
    h.merge!({ achievements: user_info.get_achievements, isAdmin: isAdmin, isPremium: isPremium })
    h.merge(posts: posts.reduce([]) { |memo, acc| memo << acc.attributes.merge(theme_id: acc.question.theme.id) })
  end

  def set_premuim
    update!(isPremium: true)
    add_achievement('Abonné')
  end

  def check_achievements
    check_anonym
    check_validate
    check_first_step
    check_influenceur
    check_symphatique
  end

  def check_anonym
    add_achievement('Homme mystère') if posts.pluck(:isAnonym).uniq.include? true
  end

  def check_validate
    add_achievement('Validé') if user_info.attributes.key(nil).nil?
  end

  def check_first_step
    add_achievement('Premier pas') if post_ids.empty?
  end

  def check_influenceur
    add_achievement('Influenceur') if posts.reduce(0) { |memo, post| memo + post.childpost.count } >= 15
  end

  def check_symphatique
    add_achievement('Symphatique') if posts.pluck(:up).count >= 100
  end

  def add_achievement(achievement_name)
    achievement = Achievement.find_by_name(achievement_name)
    user_info.achievements << achievement unless user_info.achievements.include?(achievement)
  end

end