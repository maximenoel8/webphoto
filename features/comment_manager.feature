Feature: Manage the comment

  Scenario: Log in as admin user
    Given I am authorized admin user

  Scenario: Get ips from messages
    When I open the comments page
#    Then I get the ip list of all the pages
#    And I block all the duplicate IPs
    And I delete comment in russian language