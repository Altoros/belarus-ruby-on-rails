# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do |p|
    p.first_name "First"
    p.last_name "Last"

  end
end
