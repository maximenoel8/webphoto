Feature: Create a new work type that will be use to identify the new project item

  Scenario: Log in as admin user
    Given I am authorized admin user

  Scenario: Create a new work type with description and image selected
    When I open work type create page
    Then I change the work type name
    And I update the slug field
    And I select the work type parent category
    And I update the work type description field
    And I choose the work type image
    And I register the work type changes

  Scenario: Login out
    And I logout
