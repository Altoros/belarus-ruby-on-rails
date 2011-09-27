Given /^I am logged in$/ do
  @user = Factory(:user)
end

Given /^I have (\d+) custom news article$/ do |arg1|
  CustomNews.delete_all
  arg1.to_i.times do
    Factory :custom_news
  end
  @custom_news = CustomNews.first
end

Given /^I have no comments$/ do
  CustomNews.all.each do |custom_news|
    custom_news.comments.delete_all
  end
end

Given /^I have (\d+) comment for custom news article "([^"]*)"$/ do |commnents_count, news_title|
  CustomNews.delete_all
  Factory :custom_news, :title => news_title
  @custom_news = CustomNews.find_by_title news_title
  @custom_news.comments.delete_all
  commnents_count.to_i.times do
    Factory(:comment, :custom_news_id => @custom_news.id, :user => @user)
  end
end

When /^I am stay on custom news path for "([^"]*)"$/ do |arg1|
  @custom_news = CustomNews.find_by_title arg1
end

When /^(?:|I )push "Delete comment"$/ do
  (CustomNews.find @custom_news.id).comments[0].delete
end

When /^(?:|I )push "Add comment"$/ do
  Factory(:comment, :custom_news_id => @custom_news.id, :user => @user)
end

When /^(?:|I )type "([^"]*)" in "Message" textarea$/ do |value|
  (CustomNews.find @custom_news.id).comments[0].body = value
end

Then /^I should have no comments$/ do
  (CustomNews.find @custom_news.id).comments.length.should be_eql(0)
end

Then /^I should have (\d+) comment$/ do |arg1|
  (CustomNews.find @custom_news.id).comments.length.should be_eql(arg1.to_i)
end
