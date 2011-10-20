Given /^article exists with title "([^"]*)" and content "([^"]*)"$/ do |title, content|
  Factory(:article, {:title => title, :content => content, :published => true, :user => Factory(:user)})
end

Given /^unpublished article exists with title "([^"]*)" and content "([^"]*)"$/ do |title, content|
  Factory(:article, {:title => title, :content => content, :published => false, :user => Factory(:user)})
end

When /^I follow "([^"]*)" page$/ do |title|
  visit article_path(Article.find_by_title(title))
end

Given /^there are no articles$/ do
  Article.delete_all
end

When /^I follow edit article page for "([^"]*)"$/ do |title|
  visit admin_article_path(Article.find_by_title(title)) + '/edit'
end
