Given /^article exists with title "([^"]*)" and content "([^"]*)"$/ do |title, content|
  Article.create!(:title => title, :content => content)
end

When /^I follow "(.+)" page$/ do |title|
  visit article_path(Article.find_by_title(title).id)
end

Given /^there are no articles$/ do
  Article.delete_all
end

When /^I follow edit article page for (.+)$/ do |title|
  visit article_path(Article.find_by_title(title).id) + '/edit'
end


