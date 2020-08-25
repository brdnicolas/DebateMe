class UserHasVote < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_presence_of :user_id, :post_id

  def self.records(user_id, post_id)
    where('user_id = ? AND post_id = ?', user_id, post_id)
  end

end
