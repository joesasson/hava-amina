require 'rails_helper'

describe User, type: :model do

  it "is valid with email and password" do
    john = User.create(email: "example@example.com", password: '1234')
    expect(john).to be_valid
  end


  it "is not valid without an email" do
    john = User.new(email: nil, password: '1234')
    john.save
    expect(john.errors[:email]).to include("can't be blank")
  end

  it "is not valid without a password" do
    john = User.new(email: "example@example.com", password: nil)
    john.save
    expect(john.errors[:password]).to include("can't be blank")
  end

  it "has many topics" do
    john = User.create(email: "example@example.com", password: '1234')
    the_internet = Topic.create(user_id: john.id, name: "The Internet")
    expect(john.topics.first.name).to eq("The Internet")
  end

end
