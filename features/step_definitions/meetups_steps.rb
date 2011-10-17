Given /^I come to meetups page and create meetup with topic "([^"]*)"$/ do |topic|
  Factory(:meetup, :topic => topic, :date_and_time => 1.month.from_now)
  visit('/admin/meetups')
end
