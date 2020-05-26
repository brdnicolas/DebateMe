class Question < ApplicationRecord
  belongs_to :theme

  has_many :posts, dependent: :nullify

  validates_presence_of :title, :start_time, :end_time
end
