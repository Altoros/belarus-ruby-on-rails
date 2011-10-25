Given /^I am a user named "([^"]*)" and surnamed "([^"]*)" with an email "([^"]*)" and password "([^"]*)"(?: with Ruby on Rails level "([^"]*)")?$/ do |first_name, last_name, email, password, level|
  experience = Experience.where(:level => level).first || Factory(:experience, :level => level)

  @user = Factory.build(:user,
                        :email => email,
                        :password => password,
                        :password_confirmation => password)

  @user.profile = Factory.build(:profile,
                                :first_name => first_name,
                                :last_name => last_name,
                                :experience => experience)
  @user.save
  @user.confirm!
end

Given /^no user exists with an email of "(.*)"$/ do |email|
  User.find(:first, :conditions => { :email => email }).should be_nil
end

Given /I'm editing my profile page$/ do
  Given %{I am logged in as user}
  And %{I am on the homepage}
  And %{I follow "User profile"}
  When %{I follow "Editing profile"}
  Then %{I should see "Editing profile"}
  And %{I should see "Update"}
end

When /^I fill in profile fields$/ do
  And %{I fill in "First name" with "New first name"}
  And %{I fill in "Last name" with "New last name"}
  And %{I select "#{@user.profile.experience.level}" from "Ruby on Rails level"}
end

Then /^I should see profile$/ do
  profile = @user.profile
  Then %{I should see "#{profile.first_name}"}
  And %{I should see "#{profile.last_name}"}
end

Then /^I should be already signed in$/ do
  And %{I should see "Logout"}
end

Then /^I sign out$/ do
  visit('/users/sign_out')
end

Given /^I am logout$/ do
  Given %{I sign out}
end

Given /^I am not logged in$/ do
  Given %{I sign out}
end

Given /^I am logged in as (.*)$/ do |role|
  @user = case role.to_sym
    when :user then Factory(:user)
    when :admin then Factory(:user, :is_admin => true)
    else User.new
  end

  @user.profile = Factory(:profile)
  @user.save

  Given %{I am not logged in}
  When %{I sign in as "#{@user.email}/#{@user.password}"}
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Login"}
end

When /^I sign in as a user with wrong password$/ do
  @user = Factory.build(:user)
  Given %{I am not logged in}
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{@user.email}"}
  And %{I fill in "Password" with "#{@user.password + 'qwerty'}"}
  And %{I press "Login"}
end

Then /^I should be signed in$/ do
  Then %{I should see "Signed in successfully"}
end

When /^I return next time$/ do
  And %{I go to the home page}
end

Then /^I should be signed out$/ do
  And %{I should see "Registration"}
  And %{I should see "Login"}
  And %{I should not see "Logout"}
end

Given /^I have (\d+) users?$/ do |count|
  count.to_i.times do
    Factory(:user)
  end
end

Given /^there is Ruby on Rails level "([^"]*)"$/ do |level|
  Factory(:experience, :level => level)
end
