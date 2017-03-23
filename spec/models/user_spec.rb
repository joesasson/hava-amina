require 'rails_helper'

describe User, type: :model do

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is valid with email and password" do
    john = create(:user)
    expect(john).to be_valid
  end


  it "is not valid without an email" do
    john = build(:user, email: nil)
    john.valid?
    expect(john.errors[:email]).to include("can't be blank")
  end

  it "is not valid without a password" do
    john = build(:user, password: nil)
    john.valid?
    expect(john.errors[:password]).to include("can't be blank")
  end

  it "is not valid with a duplicate email" do
    create(:user, email: 'example@example.com')
    duplicate = build(:user, email: "example@example.com")
    duplicate.valid?
    expect(duplicate.errors[:email]).to include("has already been taken")
  end

  it "has many topics" do
    john = FactoryGirl.create(:user)
    the_internet = Topic.create(user_id: john.id, name: "The Internet")
    expect(john.topics.first.name).to eq("The Internet")
  end

end
