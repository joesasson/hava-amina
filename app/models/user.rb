class User < ApplicationRecord
  # has_secure_password
  has_many :topics
  has_many :identities
  validates :email, presence: true, uniqueness: true
end
