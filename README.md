## Update a project item with new pictures
This three values are needed :
 - worktype > name ( use to search for the correct project item )
 - worktype > slug ( use to select the correct project item)
 - image_import > legend ( better to have the one from previous imported pictures for this project )

## Run the test

### Create a new project item with pictures and update main gallery
'rake cucumber:create_new_project_item'

### Update an existing project item with new pictures

'rake cucumber:update_project_item'