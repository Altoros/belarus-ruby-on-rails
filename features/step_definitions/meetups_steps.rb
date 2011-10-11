Given /^I come to meetups page and create meetup$/ do
  Meetup.new(:topic => "Belarus RoR meetup 2014", :description => "Content of meetup description", :place => 'Minsk, Belarus', :date_and_time => '2011-10-15 11:21:00').save!
  visit('/admin/meetups')
end
