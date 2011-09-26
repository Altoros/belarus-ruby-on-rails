Feature: User profile management

  Scenario: User can edit his profile
    Given I am logged in as user
    And I am on the custom_news page
    When I follow "Edit profile"
    Then I should see "Editing profile"

  Scenario: User can update his profile
    Given I'm editing my profile page
    When I fill in profile fields
    And I press "Update"
    Then I should see profile

  Scenario: Visitor can't edit profiles
    Given I am not logged in
    And I am on the custom_news page
    Then I should not see "Edit profile"
