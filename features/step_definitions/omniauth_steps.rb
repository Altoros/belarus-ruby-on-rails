Given /^I come to custom news page with name "([^"]*)"$/ do |title|
  cn=CustomNews.create!(:title => title, :content => "Some interesting news")
  visit('/custom_news/'+cn.id.to_s)
end
