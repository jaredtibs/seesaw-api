FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-email-#{n}@email.com" }
    sequence(:username) { |n| "username#{n}" }
    password 'fakepassword'
  end
end
