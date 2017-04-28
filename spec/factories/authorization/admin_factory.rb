FactoryGirl.define do
  factory :authorization_admin, class: 'Authorization::Admin' do
    id { SecureRandom.uuid }
  end
end
