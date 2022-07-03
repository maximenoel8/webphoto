Feature: Update an existing project item

  Scenario: Log in as admin user
    Given I am authorized admin user

  Scenario: Update project item gallery
    When I open the project item page
    And I select the page item
    Then I open the thumbnails grid block
    And I open add images tab
    And I add to the gallery my previously imported pictures with configure legend

  Scenario: Publish the new project item page
    And I update the page

  Scenario: Login out
    And I logout