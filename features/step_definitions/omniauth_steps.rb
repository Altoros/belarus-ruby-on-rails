Given /^A user successfully signs in with Facebook$/ do
  Given %{I sign out}
  visit "/users/auth/facebook"
end

Given /^A user unsuccessfully signs in with Facebook$/ do
  Given %{I sign out}
  visit "/users/auth/facebook"
end