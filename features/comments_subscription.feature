Feature: Comments subscription

  Scenario: Visitor should not see comments subscriptions proposal
    Given I am not logged in
    And I am on the articles page
    And article exists with title "Ruby" and content "Rails"
    When I follow "Ruby" page
    Then I should not see "Please activate to receive email notifications about new comments"

  Scenario: Registered user should see comments subscriptions proposal
    Given I am logged in as user
    And I am on the articles page
    And article exists with title "Ruby" and content "Rails"
    When I follow "Ruby" page
    Then I should see "Please activate to receive email notifications about new comments"

