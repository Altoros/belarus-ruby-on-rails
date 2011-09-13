Given /^I have custom news titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
    CustomNews.create!(:title => title)
  end
end

Given /^custom news exists with title: (.+) with content (.+)$/ do |title, content|
  CustomNews.create!(:title => title, :content => content)
end

When /^I follow "(.+)" page$/ do |title|
  visit custom_news_path(CustomNews.find_by_title(title).id)
end

Given /^there are no custom news articles$/ do
  CustomNews.delete_all
end

When /^I follow edit custom news page for (.+)$/ do |title|
  visit custom_news_path(CustomNews.find_by_title(title).id) + '/edit'
end


