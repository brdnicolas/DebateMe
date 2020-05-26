class Post < ApplicationRecord
  belongs_to :user
  belongs_to :question

  has_many :childpost, class_name: "Post",
           foreign_key: "subpost_id", dependent: :nullify

  belongs_to :subpost, class_name: "Post", optional: true

  validates_presence_of :content
end
