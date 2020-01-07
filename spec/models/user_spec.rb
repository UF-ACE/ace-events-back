require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is a valid user with valid parameters' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is not valid with a missing name' do
    user = build(:user, name: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid with a missing email' do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid with a missing role' do
    user = build(:user, role: nil)
    expect(user).to_not be_valid
  end

  it 'has a unique email' do
    first_user = create(:user)
    second_user = build(:user, email: first_user.email)
    expect(second_user).to_not be_valid
  end
end
