class User < ApplicationRecord
  has_secure_password
  has_many :topics
  validates :email, presence: true
end
