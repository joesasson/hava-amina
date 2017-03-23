FactoryGirl.define do
  factory :topic do
    sequence(:user_id)
    sequence(:name) { |n| "Interesting Topic #{n}" }
  end
end
