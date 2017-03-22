class Topic < ApplicationRecord
  belongs_to :user
  has_many :insights
  validates :name, presence: true
end
