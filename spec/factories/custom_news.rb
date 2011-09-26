# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :custom_news do
    title "MyString"
    content "MyText"
    status 1
  end
end
