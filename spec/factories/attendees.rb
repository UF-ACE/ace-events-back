FactoryBot.define do
  factory :attendee do
    association :event
    association :user
  end
end
