FactoryGirl.define do
  factory :event_user do
    liked false
    association :event
  end
end
