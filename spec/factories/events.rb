FactoryBot.define do
  starting_date = FFaker::Time.datetime
  factory :event do
    name { FFaker::Name.name }
    short_description { FFaker::BaconIpsum.phrase }
    description { FFaker::BaconIpsum.paragraph }
    location { FFaker::Address.city }
    start_time { starting_date }
    end_time { starting_date + 1.hour }
    sign_in_id { Event.gen_sign_in_id() }
  end
end
