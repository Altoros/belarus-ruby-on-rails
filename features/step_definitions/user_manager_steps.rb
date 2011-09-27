Given /^I have signed up with email "([^"]*)" successfully$/ do |email|
  Given %{I am not logged in}
  When %{I go to the sign up page}
  And %{I fill in "#{ email }" for "Email"}
  And %{I fill in "password" for "Password"}
  And %{I fill in "first name" for "First name"}
  And %{I fill in "last name" for "Last name"}
  And %{I fill in "password" for "Password"}
  And %{I fill in "password" for "Password confirmation"}
  And %{I press "Sign up"}
  Then %{I should see "You have signed up successfully."}
end

Given /^I have (\d+) users\((\d+) of them is admin\)$/ do |arg1, arg2|
  Given %{I have signed up with email "admin@example.com" successfully}
  admin = User.find_by_email("admin@example.com")
  admin.change_admin_state!
  admin.confirm!
  Given %{I have signed up with email "user@example.com" successfully}
  User.find_by_email("user@example.com").confirm!
end

Given /^I am logged in with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign in page}
  And %{I fill in "#{email}" for "Email"}
  And %{I fill in "#{password}" for "Password"}
  And %{I press "Sign in"}
end

When /^(?:|I )visit (.+)$/ do |page_url|
  visit "/#{page_url}"
end

When /^I click "([^"]*)"$/ do |arg1|
  click_link arg1
end

Then /^I restricted to visit page$/ do
  assert_equal 403, page.driver.status_code
end