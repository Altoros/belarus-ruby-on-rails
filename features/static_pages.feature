Feature: Custom news management

  Scenario: User can see "About" page
    Given I am on the articles page
    When I go to About page
    Then I should see "About"

  Scenario: User can see "Friends" page
    Given I am on the articles page
    When I go to Friends page
    Then I should see "Friends"
