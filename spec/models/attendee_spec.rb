require 'rails_helper'

RSpec.describe Attendee, type: :model do
  it 'is valid with all valid parameters' do
    attendee = build(:attendee)
    expect(attendee).to be_valid
  end

  it 'is not valid with a missing user' do
    attendee = build(:attendee, user: nil)
    expect(attendee).to_not be_valid
  end

  it 'is not valid with a missing event' do
    attendee = build(:attendee, event: nil)
    expect(attendee).to_not be_valid
  end

  it 'is not valid if a duplicate attendee' do
    a = create(:attendee)
    attendee = build(:attendee, event: a.event, user: a.user)
    expect(attendee).to_not be_valid
  end
end
