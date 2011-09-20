# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |u|
    u.profile Factory :profile
    u.email 'user@test.com'
    u.password 'password'
    u.confirmed_at Time.now
    u.confirmation_sent_at  Time.now
  end
end

