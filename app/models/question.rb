class Question < ApplicationRecord
  belongs_to :theme

  validates_presence_of :title, :start_time, :end_time
end
