Given /^I come to article page with name "([^"]*)"$/ do |title|
  cn = Factory(:article, {:title => title, :content => "Some interesting news", :user => Factory(:user)})
  visit('/articles/'+cn.id.to_s)
end
