class Post < ApplicationRecord
  belongs_to :user
  # belongs_to :post
  # belongs_to :question

  validates_presence_of :content
end
