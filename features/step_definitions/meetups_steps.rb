Given /^I come to meetups page and create meetup with topic "([^"]*)"$/ do |topic|
  Meetup.new(:topic => topic, :description => "Content of meetup description", :place => 'Minsk, Belarus', :date_and_time => '2014-10-15 11:21:00').save!
  visit('/admin/meetups')
end
