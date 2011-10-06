Feature: Comments subscription

  Scenario: User can subscribe/unsubscribe to comments notifications by email
    Given I am logged in as user
    And I am on the articles page
    When I follow "Edit profile"
    And the "I would like to receive email notifications about new comments" checkbox should not be checked
    And I check "I would like to receive email notifications about new comments"
    And I press "Update Profile"
    And I follow "Edit profile"
    Then the "I would like to receive email notifications about new comments" checkbox should be checked
