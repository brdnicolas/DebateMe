class UserHasVote < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.records(user_id, post_id)
    self.where("user_id = ? AND post_id = ?", user_id, post_id)
  end

  validates_presence_of :user_id, :post_id
end
