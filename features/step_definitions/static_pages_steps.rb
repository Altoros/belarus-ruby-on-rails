Given /^static page "([^"]*)" exists$/ do |permalink|
  Factory("#{permalink}_page".to_sym)
end

When /^I follow static "([^"]*)" page$/ do |title|
  visit static_page_path(StaticPage.find_by_title(title))
end

When /^I follow edit static page for "([^"]*)"$/ do |title|
  visit admin_static_page_path(StaticPage.find_by_title(title)) + '/edit'
end
