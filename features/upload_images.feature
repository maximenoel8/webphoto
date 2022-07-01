Feature: Upload pictures to website with the same legend

  Scenario: Log in as admin user
    Given I am authorized admin user

  Scenario: Create a list with all the pictures in root
    When I get the images list

  Scenario: Upload all pictures from the pictures list
    Then I upload all the images to the web site and update there legend

  Scenario: Login out
    And I logout