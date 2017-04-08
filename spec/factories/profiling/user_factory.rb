FactoryGirl.define do
  factory :profiling_user, class: 'Profiling::User' do
    id               { SecureRandom.uuid }
    first_name       Faker::Name.first_name
    last_name        Faker::Name.last_name
    sequence(:email) { |n| "pivorak.member#{n}@example.com" }

    trait :verified do
      verified true
    end

    trait :tester do
      email      'tester@example.com'
      first_name 'Tester'
      last_name  'User'
    end
  end
end
