Feature: User profile management

  Scenario: User can update his profile
    Given I am not logged in
    Given I am a user named "qweqwe" and surnamed "rtyrty" with an email "456@mail.com" and password "asdasd"

    When I go to the sign in page
    And I fill in "Email" with "456@mail.com"
    And I fill in "Password" with "asdasd"
    And I press "Sign in"
    When I follow "Edit profile"
#    And I fill in "email" with "user@test.com"
    And I fill in "First name" with "foo"
    And I fill in "Last name" with "asd"
    And press "Update"
    Then I should see "foo"