Given /^article exists with title "([^"]*)" and content "([^"]*)"$/ do |title, content|
  Factory(:article, {:title => title, :content => content, :published => true})
end

Given /^agregated article exists with title "([^"]*)" and content "([^"]*)" and rss_link "([^"]*)"$/ do |title, content, rss_link|
  Factory(:article, {:title => title, :content => content, :published => true, :rss_link => rss_link})
end

Given /^unpublished article exists with title "([^"]*)" and content "([^"]*)"$/ do |title, content|
  Factory(:article, {:title => title, :content => content, :published => false})
end

When /^I follow "([^"]*)" page$/ do |title|
  visit article_path(Article.internal.find_by_title(title))
end

When /^I follow agregated "([^"]*)" page$/ do |title|
  visit agregated_article_path(Article.external.find_by_title(title))
end

Given /^there are no articles$/ do
  Article.delete_all
end

When /^I follow edit article page for "([^"]*)"$/ do |title|
  visit admin_article_path(Article.internal.find_by_title(title)) + '/edit'
end
