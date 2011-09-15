Given /^I am logged in$/ do
  Given %{I am on the home page}
  And %{I go to the sign up page}
  And %{I fill in "Email" with "user@test.com"}
  And %{I fill in "First name" with "Testy"}
  And %{I fill in "Last name" with "McUserton"}
  And %{I fill in "Password" with "please"}
  And %{I fill in "Password confirmation" with "please"}
  And %{I press "Sign up"}
  Then %{I should see "You have signed up successfully."}
  When %{I go to the sign in page}
  And %{I fill in "Email" with "user@test.com"}
  And %{I fill in "Password" with "please"}
  And %{I press "Sign in"}
end

Given /^I have (\d+) custom news article$/ do |arg1|
  CustomNews.delete_all
  arg1.to_i.times do
    CustomNews.new({title: "Title", content: "CustomNews's text"}).save
  end
  @custom_news = CustomNews.first
end

Given /^I have no comments$/ do
  CustomNews.all.each do |custom_news|
    custom_news.comments.delete_all
  end
end

Given /^I have (\d+) comment for custom news article "([^"]*)"$/ do |arg1, arg2|
  CustomNews.new({ title: arg2, content: "current_news body" }).save
  @custom_news = CustomNews.find_by_title arg2
  @custom_news.comments.delete_all
  arg1.to_i.times do
    Comment.new({ body: "I'm a test comment", custom_news: (CustomNews.find @custom_news.id), user: @user}).save
  end
end

When /^I am stay on custom news path for "([^"]*)"$/ do |arg1|
  @custom_news = CustomNews.find_by_title arg1
end

When /^(?:|I )push "Delete comment"$/ do
  (CustomNews.find @custom_news.id).comments[0].delete
end

When /^(?:|I )push "Add comment"$/ do
  Comment.new({ body: "I'm a test comment", custom_news: @custom_news, user: @user }).save
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
