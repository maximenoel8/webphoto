Feature: Update main gallery

  Scenario: Log in as admin user
    Given I am authorized admin user

  Scenario: Update main gallery portfolio
    When I go to page tab
    Then I select the main gallery
    And I open the portfolio grid
    And I add the work type to list
    And I register the changes from the block
    And I publish the page