require 'rails_helper'

describe Topic, type: :model do
  it "is valid with valid attributes" do
    user = User.create(email: 'example@example.com', password: '1234')
    the_internet = Topic.create(user_id: user.id, name: "The Internet")
    expect(the_internet).to be_valid
  end

  it "is not valid with a blank name" do
    user = User.create(email: 'example@example.com', password: '1234')
    the_internet = Topic.create(user_id: user.id, name: nil)
    expect(the_internet.errors[:name]).to include("can't be blank")
  end
end
