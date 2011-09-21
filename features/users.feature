Feature: User profile management

  Scenario: User can update his profile
    Given I'm editing my profile page
    When I fill in profile fields
    And press "Update"
    Then I should see profile
