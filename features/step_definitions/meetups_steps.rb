# When I select "November 23, 2004 11:20" as the "Preferred" date and time
# And I select "November 25, 2004 10:30" as the "Alternative" date and time
When /^(?:|I )select "([^\"]*)" as the "([^\"]*)" date$/ do |date, date_label|
  date = Date.parse(date)
  base_dom_id = get_base_dom_id_from_label_tag(date_label)

  find(:xpath, "//select[@id='#{base_dom_id}_1i']").select(date.year.to_s)
  find(:xpath, "//select[@id='#{base_dom_id}_2i']").select(I18n.l date, :format => '%B')
  find(:xpath, "//select[@id='#{base_dom_id}_3i']").select(date.day.to_s)
end
Given /^I come to meetups page and create meetup with topic "([^"]*)"$/ do |topic|
  Meetup.new(:topic => topic, :description => "Content of meetup description", :place => 'Minsk, Belarus', :date_and_time => '2011-10-15 11:21:00').save!
  visit('/admin/meetups')
end
