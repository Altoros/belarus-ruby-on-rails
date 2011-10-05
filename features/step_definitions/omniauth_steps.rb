Given /^I come to article page with name "([^"]*)"$/ do |title|
  cn = Factory(:article, {:title => title, :content => "Some interesting news"})
  visit('/articles/'+cn.id.to_s)
end
