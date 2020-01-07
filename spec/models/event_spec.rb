require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'is valid with all valid parameters' do
    event = build(:event)
    expect(event).to be_valid
  end

  it 'is not valid with a missing name' do
    event = build(:event, name: nil)
    expect(event).to_not be_valid
  end

  it 'is valid with a missing description' do
    event = build(:event, description: nil)
    expect(event).to be_valid
  end

  it 'is not valid with a missing location' do
    event = build(:event, location: nil)
    expect(event).to_not be_valid
  end

  it 'is not valid with a missing start time' do
    event = build(:event, start_time: nil)
    expect(event).to_not be_valid
  end

  it 'is not valid with a missing end time' do
    event = build(:event, end_time: nil)
    expect(event).to_not be_valid
  end

  it 'is not valid with a missing sign in id' do
    event = build(:event, sign_in_id: nil)
    expect(event).to_not be_valid
  end

  it 'is not valid with a conflicting sign in id' do
    old_event = create(:event)
    event = build(:event, sign_in_id: old_event.sign_in_id)
    expect(event).to_not be_valid
  end

  it 'is not valid if end time is before start time' do
    old_event = create(:event)
    event = build(:event, start_time: old_event.end_time, end_time: old_event.start_time)
    expect(event).to_not be_valid
  end
end
