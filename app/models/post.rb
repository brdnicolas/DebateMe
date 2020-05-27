class Post < ApplicationRecord
  belongs_to :user
  belongs_to :question

  has_many :childpost, class_name: "Post",
           foreign_key: "subpost_id", dependent: :nullify

  belongs_to :subpost, class_name: "Post", optional: true

  has_many :user_has_votes, dependent: :destroy

  validates_presence_of :content

  def get_vote_ids
    votes_id = self.user_has_vote_ids
    votes_id.inject([])  { |memo,element| memo.append(UserHasVote.find(element).user_id) }
  end

  def up_vote
    self.update(up: self.up + 1)
  end
  def down_vote
    self.update(up: self.up - 1) if self.up > 0
  end

end
