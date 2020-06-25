class Report < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_presence_of :reason, :post, :user
end
