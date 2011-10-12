# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    first_name "First"
    last_name "Last"
    experience
  end
end
