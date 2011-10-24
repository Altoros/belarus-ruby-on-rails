# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :static_page do
    title "MyString"
    permalink "MyString"
    content "MyText"
  end

  factory :about_page, :parent => :static_page do
    title 'About'
    permalink 'about'
    content 'Some example'
  end
end