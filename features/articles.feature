Feature: Articles management

  Scenario: Visitor can see articles list
    Given article exists with title "Ruby" and content "Rails"
    And I am not logged in
    When I am on the articles page
    Then I should see "Ruby"
    And I should see "Rails"

  Scenario: Visitor can read article
    Given article exists with title "Ruby" and content "It rocks!"
    And I am not logged in
    When I follow "Ruby" page
    Then I should see "Ruby"
    And I should see "It rocks!"

  Scenario: Visitor should see no news message
    Given there are no articles
    And I am not logged in
    When I am on the articles page
    Then I should see "There is no news at the moment."

  # TODO DRY scenarios, reduce repetitions
  Scenario: Visitor can't create a new article
    Given I am not logged in
    And I am on the articles page
    Then I should not see "New article"

  Scenario: User can't create a new article
    Given I am logged in as user
    And I am on the articles page
    Then I should not see "New article"

  Scenario: Admin can add article
    Given I am logged in as admin
    When I go to new article path
    And I fill in "Title" with "Ruby rocks"
    And I fill in "Content" with "So hard"
    And I press "Create"
    Then I should see "Ruby rocks"
    And I should see "So hard"

  Scenario: Visitor can't update article
    Given article exists with title "Ruby" and content "It rocks!"
    And I am not logged in
    And I am on the articles page
    Then I should not see /^Edit$/

  Scenario: User can't update article
    Given article exists with title "Ruby" and content "It rocks!"
    And I am logged in as user
    And I am on the articles page
    Then I should not see /^Edit$/

  Scenario: Admin can update article
    Given article exists with title "Ruby" and content "It rocks!"
    And I am logged in as admin
    When I am on the articles page
    And I follow edit article page for Ruby
    And I fill in "Title" with "Ruby7"
    And I fill in "Content" with "7th"
    And I press "Update"
    Then I should see "Ruby7"
    And I should see "7th"

  Scenario: Visitor can't delete article
    Given article exists with title "Ruby7" and content "It rocks!"
    And I am not logged in
    When I am on the articles page
    Then I should not see "Delete"

  Scenario: User can't delete article
    Given article exists with title "Ruby7" and content "It rocks!"
    And I am logged in as user
    When I am on the articles page
    Then I should not see "Delete"

  Scenario: Admin can delete article
    Given article exists with title "Ruby7" and content "It rocks!"
    And I am logged in as admin
    When I am on the articles page
    And I follow "Delete"
    Then I should not see "Ruby7"
    And I should not see "It rocks!"
