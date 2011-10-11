FactoryGirl.define do
  factory :meetup do
    topic 'Topic of meetup'
    description 'Description of meetup'
    place 'Minsk, Belarus'
    date_and_time Time.now + 1.week
  end
end
