Feature: Custom news management

  Scenario: User can see "About" page
    Given I am on the custom_news page
    When I go to About page
    Then I should see "It's a stub page for about entries"

  Scenario: User can see "Friends" page
    Given I am on the custom_news page   
    When I go to Friends page
    Then I should see "It's a stub page for friends entries"
