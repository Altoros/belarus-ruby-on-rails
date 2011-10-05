Given /^I come to article page with name "([^"]*)"$/ do |title|
  cn=Article.create!(:title => title, :content => "Some interesting news", :status => 0)
  visit('/articles/'+cn.id.to_s)
end
