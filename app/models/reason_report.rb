class ReasonReport < ApplicationRecord
  has_many :reports

  validates_presence_of :reason
  validates_uniqueness_of :reason
end
