class Insight < ApplicationRecord
  belongs_to :topic
  validates :text, presence: true
end
