Feature: Custom news management

  Scenario: Visitor can see custom news list
    Given custom news exists with title: Ruby with content Rails
    And I am not logged in
    When I am on the custom_news page
    Then I should see "Ruby"
    And I should see "Rails"

  Scenario: Visitor can read custom news
    Given custom news exists with title: Ruby with content "It rocks!"
    And I am not logged in
    When I follow "Ruby" page
    Then I should see "Ruby"
    And I should see "It rocks!"

  Scenario: Visitor should see no news message
    Given there are no custom news articles
    And I am not logged in
    When I am on the custom_news page
    Then I should see "There is no news at the moment."

  Scenario: Admin can add custom news
    Given I am logged in as admin
    When I go to new custom news path
    And I fill in "Title" with "Ruby rocks"
    And I fill in "Content" with "So hard"
    And I press "Create"
    And I should see "Ruby rocks"
    And I should see "So hard"

  Scenario: Admin can update custom news
    Given I am logged in as admin
    Given custom news exists with title: Ruby with content "It rocks!"
    When I am on the custom_news page
    And I follow edit custom news page for Ruby
    And I fill in "Title" with "Ruby7"
    And I fill in "Content" with "7th"
    And I press "Update"
    And I should see "Ruby7"
    And I should see "7th"

  Scenario: Admin can delete custom news
    Given I am logged in as admin
    Given custom news exists with title: Ruby7 with content "It rocks!"
    When I am on the custom_news page
    And I follow "Delete"
    And I should not see "Ruby7"
    And I should not see "It rocks!"
