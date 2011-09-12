Feature: Custom news management

  Scenario: Visitors can see custom news
    Given I am Visitor
    And there are custom news articles titled "Ruby rocks" and "Rails rulez"
    When I go to main page
    Then I should see "Ruby rocks"
    And I should see "Rails rulez"

  Scenario: Visitor can read custom news
    Given I am Visitor
    And there are custom news articles titled "Ruby rocks" with content "So hard"
    When I go to main page
    And I follow "Ruby rocks"
    Then I should be on custom news path
    And I should see "So hard"

  Scenario: Admin can add custom news
    Given I am Admin
    And there are no custom news articles
    When I go to new custom news path
    And I fill in "title" with "Ruby rocks"
    And I fill in "content" with "So hard"
    And I press "Add"
    Then I should go to custom news path
    And I should see "Ruby rocks"
    And I should see "So hard"

  Scenario: Admin can edit custom news
    Given I am Admin
    And I have 1 custom news article titled "Ruby rocks"
    When I go to main page
    And I follow edit custom news path for "Ruby rocks"
    Then I should be on edit custom news path

  Scenario: Admin can update custom news
    Given I am Admin
    And I have 1 custom news article titled "Ruby rocks" with content "So hard"
    When I follow edit custom news path for "Ruby rocks"
    And I fill in "content" with "Hello world"
    Then I should have 1 custom news article titled "Ruby rocks" with content "Hello world"

  Scenario: Admin can delete custom news
    Given I am Admin
    And I have 1 custom news article titled "Ruby rocks"
    And I am on main page
    When I follow "Delete"
    Then I should have no custom news articles


