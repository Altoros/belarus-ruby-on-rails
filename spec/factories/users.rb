FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'

    after_build do |user|
      user.skip_confirmation!
      user.profile = Factory.build(:profile)
    end

    after_stub do |user|
      user.confirmed_at = Time.now
      user.confirmation_sent_at = Time.now
    end
  end
end
