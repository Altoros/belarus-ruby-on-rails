Feature: Comments management for articles.
  Background:
    Given I am logged in as user
    And article exists with title "Article title" and content "Article content"
    And I am on the articles page
    When I follow "Article title" page

  Scenario: Logged in users can add comments for article
    Then I create new comment with text "Nice article!"
    Then I should see "Nice article!"

  @javascript
  Scenario: Logged in users can add nested comments
    Then I create new comment with text "Nice article!"
    Then I should see "Nice article!"
    Then I create new nested comment with text "Nested comment"
    Then I should see "Nested comment"

  @javascript
  Scenario: Logged in users can delete their comments
    Then I create new comment with text "Nice article!"
    Then I create new comment with text "Leaved comment"
    Then I create new nested comment with text "Nested comment"
    When I delete comment "Nice article!"
    Then I should not see "Nice article!"
    And I should not see "Nested comment"
    And I should see "Leaved comment"


  @javascript
  Scenario: Logged in users cancel creating nested comments
    Then I create new comment with text "Nice article!"
    Then I click "Answer"
    Then I fill in "nested_comment_body" with "Will be canceled comment"
    When I click "Cancel"
    Then I should not see "Will be canceled comment"
