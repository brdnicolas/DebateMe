class Report < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :reason_report

  validates_presence_of :reason_report, :post, :user
end
