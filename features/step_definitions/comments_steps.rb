Given /^I am logged in$/ do
end

Given /^I have (\d+) custom news article$/ do |arg1|
  CustomNews.delete_all
  arg1.to_i.times do
    CustomNews.new({:title => "Title", :content => "CustomNews's text"}).save
  end
  @custom_news = CustomNews.first
end

Given /^I have no comments$/ do
  CustomNews.all.each do |custom_news|
    custom_news.comments.delete_all
  end
end

Given /^I have (\d+) comment for custom news article "([^"]*)"$/ do |arg1, arg2|
  CustomNews.delete_all
  CustomNews.new({ :title => arg2, :content => "current_news body" }).save
  @custom_news = CustomNews.find_by_title arg2
  @custom_news.comments.delete_all
  arg1.to_i.times do
    Comment.new({ :body => "I'm a test comment", :custom_news => (CustomNews.find @custom_news.id)}).save
  end
end

When /^I am stay on custom news path for "([^"]*)"$/ do |arg1|
  @custom_news = CustomNews.find_by_title arg1
end

When /^(?:|I )push "Delete comment"$/ do
  (CustomNews.find @custom_news.id).comments[0].delete
end

When /^(?:|I )push "Add comment"$/ do
  Comment.new({ :body => "I'm a test comment", :custom_news => @custom_news}).save
end

When /^(?:|I )type "([^"]*)" in "Message" textarea$/ do |value|
  (CustomNews.find @custom_news.id).comments[0].body = value
  (CustomNews.find @custom_news.id).comments[0].save
end

Then /^I should have no comments$/ do
  (CustomNews.find @custom_news.id).comments.length.should be_eql(0)
end

Then /^I should have (\d+) comment$/ do |arg1|
  (CustomNews.find @custom_news.id).comments.length.should be_eql(arg1.to_i)
end
