require 'rails_helper'

describe Insight, type: :model do
  it "is valid with valid attributes" do
    user = create(:user)
    the_internet = Topic.create(user_id: user.id, name: "The Internet")
    connects_computers = Insight.create(topic_id: the_internet.id, text: "It connects different computers to each other")
    expect(connects_computers).to be_valid
  end

  it "is not valid with blank text" do
    user = create(:user)
    the_internet = Topic.create(user_id: user.id, name: "The Internet")
    connects_computers = Insight.create(topic_id: the_internet.id, text: nil)
    expect(connects_computers.errors[:text]).to include("can't be blank")
  end
end
