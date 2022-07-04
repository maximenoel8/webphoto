Feature: Create new project item

  Scenario: Log in as admin user
    Given I am authorized admin user
    
  Scenario: Create project item and configure basics
    When I create a new project item
    Then I change the project title
    And I select the work type
    And I change 'Image mise en avant' of the project item
    And I change page style to edge to edge
    And I change gallery thumbnail link type to direct link lightbox
    And I switch to page builder mode
    And I import Wanaka block
    
  Scenario: Edit hero image block
    When I open the edit page hero image block
    Then I update the hero image block picture
    And I change the hero image block title
    And I register the changes from the block
    
  Scenario: Add pictures to thumbnails grid
    When I open the thumbnails grid block
    Then I open add images tab
    And I clean the images in thumbnails grid
    And I add to the gallery my previously imported pictures with configure legend

  Scenario: Publish the new project item page
    And I publish the project

  Scenario: Login out
    And I logout