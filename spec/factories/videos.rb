# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    title "Video"
    description "This's a video."
    content "http://www.youtube.com/watch?v=oUb7Wc5kOMQ"
  end
end
