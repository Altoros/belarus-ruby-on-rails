FactoryGirl.define do
  factory :user do |u|
    u.sequence(:email) { |n| "user#{n}@example.com" }
    u.password 'password'

    u.after_build do |uu|
      uu.skip_confirmation!
      uu.profile = Factory.build(:profile)
    end
    
    u.after_stub do |uu|
      uu.confirmed_at = Time.now
      uu.confirmation_sent_at = Time.now
    end
  end
end
