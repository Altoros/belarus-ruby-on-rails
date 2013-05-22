FactoryGirl.define do
  factory :meetup do
    topic 'Topic of meetup'
    description 'Description of meetup'
    place 'Minsk, Belarus'
    letter_subject 'Letter subject'
    letter_body 'Letter body'
    date_and_time Time.now + 1.day
    finish_date_and_time Time.now + 1.month
  end
end
