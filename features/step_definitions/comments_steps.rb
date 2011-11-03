Then /^I create new comment with text "([^"]*)"$/ do |body|
  Then %{I fill in "comment_body" with "#{ body }"}
  And %{I press "Comment"}
end

Then /^I create new nested comment with text "([^"]*)"$/ do |body|
  Then %{I click "Answer"}
  Then %{I fill in "nested_comment_body" with "#{ body }"}
  And %{I press "nested_comment_submit"}
end

When /^I delete comment "([^"]*)"$/ do |body|
  within('.comment_wrapper') do
    if first('.comment_text').text() == body
      first('.comment-delete-link').click
      When %{I confirm popup}
    end
  end
end

