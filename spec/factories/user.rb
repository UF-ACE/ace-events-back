FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email  { FFaker::Internet.email }
    role { 0 }
  end

  factory :chair, parent: :user do
    role { 1 }
  end

  factory :eboard, parent: :user do
    role { 2 }
  end
end