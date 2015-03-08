FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    avatar_url { Faker::Avatar.image }
    provider 'facebook'
    providerid { Faker::Bitcoin.address[0..16] }
    auth_token { Faker::Bitcoin.address[0..16] }
  end

end
