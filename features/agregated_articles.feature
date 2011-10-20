Feature: Agregated articles management

  Scenario: Visitor can see agregated articles list
    Given agregated article exists with title "Ruby" and content "Rails" and rss_link "Link"
    And I am not logged in
    When I am on the agregated articles page
    Then I should see "Ruby"
    And I should see "Rails"

  Scenario: Visitor can read article
    Given agregated article exists with title "Ruby" and content "It rocks!" and rss_link "Link"
    And I am not logged in
    When I follow agregated "Ruby" page
    Then I should see "Ruby"
    And I should see "It rocks!"

  Scenario: Visitor should see no news message
    Given there are no articles
    And I am not logged in
    When I am on the articles page
    Then I should see "There is no news at the moment"

  Scenario: Visitor can't delete agregated article
    Given agregated article exists with title "Ruby7" and content "It rocks!" and rss_link "Link"
    And I am not logged in
    When I am on the agregated articles page
    Then I should not see "Delete"

  Scenario: User can't delete agregated article
    Given agregated article exists with title "Ruby7" and content "It rocks!" and rss_link "Link"
    And I am logged in as user
    When I am on the agregated articles page
    Then I should not see "Delete"

  Scenario: Admin can delete agregated article
    Given agregated article exists with title "Ruby7" and content "It rocks!" and rss_link "Link"
    And I am logged in as admin
    When I am on the agregated articles page
    And I follow "Delete"
    Then I should not see "Ruby7"
    And I should not see "It rocks!"
