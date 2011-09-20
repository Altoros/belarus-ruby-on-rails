Given /^I have (\d+) users\((\d+) of them is admin\)$/ do |arg1, arg2|
  (user = User.new(email: "admin@example.com",
                  password: "password",
                  password_confirmation: "password")).confirm!
  Profile.new(first_name: "Admin",
              last_name: "Admin",
              user: user).save
  user.change_admin_state
  (user = User.new(email: "user@example.com",
                  password: "password",
                  password_confirmation: "password")).confirm!
  Profile.new(first_name: "User",
              last_name: "User",
              user: user).save
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
