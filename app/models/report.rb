class Report < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :reason_report

  validates_presence_of :reason_report, :post, :user

  def get_reason
    self.reason_report.attributes[:reason]
  end
end
