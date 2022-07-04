## -------------------------------------------
#
# create project item steps
#
## -------------------------------------------

When(/^I create a new project item$/) do
  visit "#{SITE}/post-new.php?post_type=mtheme_portfolio"
end

When(/^I open the project item page$/)do
  visit "#{SITE}/edit.php?post_type=mtheme_portfolio"
end

Then(/^I change the project title$/) do
  fill_in('title', with: $website_configuration['project_items']['title'])
end

And(/^I select the work type$/) do
  find(:xpath, "//label[@class='selectit' and contains(.,'#{$website_configuration['work_type']['name']}')]").click
end

And(/^I change 'Image mise en avant' of the project item$/) do
  click_on_first_visible_element("//a[@id='set-post-thumbnail']")
  wait_spinner
  fill_in_visible_element("//input[@id='media-search-input']", $website_configuration['project_items']['image'])
  wait_spinner
  step %(I select the first image)
  click_on_first_visible_element("//button[text()='Définir l’image mise en avant']")
end

And(/^I change page style to edge to edge$/) do
  click_on_first_visible_element("//img[@data-value='edge-to-edge']")
  check_element_present("//img[@data-value='edge-to-edge' and contains(@class,'of-radio-img-selected')]")
end

And(/^I change gallery thumbnail link type to direct link lightbox$/) do
  click_on_first_visible_element("//img[@data-value='Lightbox_DirectURL']")
  check_element_present("//img[@data-value='Lightbox_DirectURL' and contains(@class,'of-radio-img-selected')]")
end

And(/^I switch to page builder mode$/) do
  find(:xpath, "//span[@class='mtheme-pb-choice mtheme-pb-yes']").click
  check_text_present('Using Page Builder.')
end

And(/^I import Wanaka block$/) do
  #clear
  find(:xpath, "//a[@class='emptyTemplates']").click

  #import block
  find(:id, 'import-a-block').click
  find(:xpath, "//div[@id='mtheme-pb-import-a-block']//textarea").fill_in with: BLOCK_IMPORT
  find(:xpath, "//button[@class='button button-primary' and text()='Import']").click
end

When(/^I open the edit page hero image block$/) do
  # Open Hero image block edit table
  find(:xpath, "//li[@title='Add a Hero Image' and contains(@class,'ui-sortable-handle')]").click
  find(:xpath, "//li[@title='Add a Hero Image' and contains(@class,'ui-sortable-handle')]//a[@class='block-edit']").click
end

Then(/^I update the hero image block picture$/) do
  # Upload picture to hero block
  find(:xpath, "//div[@aria-hidden='false']//a[@class='aq_upload_button button']").click
  fill_in_visible_element("//input[@id='media-search-input']", $website_configuration['project_items']['hero_image']['image'])
  wait_spinner
  step %(I select the first image)
  click_on_first_visible_element("//button[text()='Sélectionner']")
end

And(/^I change the hero image block title$/) do
  # Change title hero image
  find(:xpath, "//div[@aria-hidden='false']//label[text()='Intensity for Text and ui elements']").visible?
  execute_script("document.querySelector(\"div[aria-hidden='false'] div.sortable-handle a\",':before').click()")
  fill_in("aq_blocks[aq_block_2][tabs][1][title]", with: $website_configuration['project_items']['hero_image']['title'])
  fill_in("aq_blocks[aq_block_2][tabs][1][subtitle]", with: $website_configuration['project_items']['hero_image']['subtitle'])
end

When(/^I open the thumbnails grid block$/) do
  find(:xpath, "//li[@title='Generate a Thumbnail Grid']").click
  find(:xpath, "//li[@title='Generate a Thumbnail Grid']//a[@class='block-edit']").click
end

Then(/^I open add images tab$/) do
  click_on_first_visible_element("//button[@class='mtheme-gallery-selector']")
  wait_spinner
end

And(/^I clean the images in thumbnails grid$/) do
  images = page.all(:xpath, "//button[@class='button-link attachment-close media-modal-icon']")
  puts "Cleaning the #{images.length} images"
  images.each { |image|
    image.click
  }
  check_text_present('Aucun élément trouvé.')
end

And(/^I add to the gallery my previously imported pictures with configure legend$/) do
  click_on_first_visible_element("//a[text()='Ajouter à la galerie']")
  wait_spinner
  fill_in('media-search-input', with: $website_configuration['image_import']['legend'])
  wait_spinner
  images = page.all(:xpath, "//li[@class='attachment save-ready']")
  puts "#{images.length} images will be added"

  images.each { |image|
    image.click
  }
  click_on_first_visible_element("//button[text()='Ajouter à la galerie']")
  click_on_first_visible_element("//button[text()='Mettre à jour la galerie']")
  click_on_first_visible_element("//button[text()='Done']")
  # click_on_visible_element("//input[@id='save-post']")
end

When(/^I select the page item$/) do
  fill_in('post-search-input', with: $website_configuration['work_type']['name'])
  click_button('search-submit')
  click_on_first_visible_element("//tr[contains(@class,'types-#{$website_configuration['work_type']['slug']}')]//a[@class='row-title']")
end