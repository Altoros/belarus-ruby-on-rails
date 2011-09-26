FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@example.com"
    end
    password 'password'
    confirmed_at Time.now
    confirmation_sent_at  Time.now
  end
end
