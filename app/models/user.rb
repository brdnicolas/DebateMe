class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates_presence_of :firstname, :lastname, :username, :password_digest, :email
  validates_uniqueness_of :username, :email, case_sensitive: true
end