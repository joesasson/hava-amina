require 'rails_helper'

describe Topic, type: :model do
  it "is valid with valid attributes" do
    user = create(:user)
    the_internet = create(:topic, user: user)
    expect(the_internet).to be_valid
  end

  it "is not valid with a blank name" do
    user = create(:user)
    the_internet = build(:topic, user: user, name: nil)
    the_internet.valid?
    expect(the_internet.errors[:name]).to include("can't be blank")
  end
end
