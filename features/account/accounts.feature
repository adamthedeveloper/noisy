Feature: My Account
  In order to see account and session related information
  As a user
  I want to be able to do account related tasks

  Scenario: Logging In
    Given I am on the home page
    Then I should see "Sign In"
    Then I follow "Sign In"
    When I fill in "email" with ""
        
    