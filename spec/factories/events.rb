FactoryGirl.define do
  factory :event do
    headline { Faker::Lorem.sentence(3, false, 4) }
    description { Faker::Lorem.paragraph }
    date { Date.tomorrow }
  end
end
