## -------------------------------------------
#
# create project item steps
#
# --------------------------------------------

When(/^I create a new project item$/) do
  visit "#{SITE}/post-new.php?post_type=mtheme_portfolio"
end

Then(/^I change the project title by "([^"]*)"$/) do | title |
  fill_in('title', with: title)
end

And(/^I select the worktype "([^"]*)"$/) do | worktype |
  find(:xpath, "//label[@class='selectit' and contains(.,'#{worktype}')]").click()
end

And(/^I switch to page builder mode$/) do
  find(:xpath,"//span[@class='mtheme-pb-choice mtheme-pb-yes']").click()
  has_content?('Using Page Builder.')
end

And(/^I import Wanaka block$/) do
  #clear
  find(:xpath,"//a[@class='emptyTemplates']").click()

  #import block
  find(:id,'import-a-block').click()
  find(:xpath,"//div[@id='mtheme-pb-import-a-block']//textarea").fill_in with: BLOCK_IMPORT
  find(:xpath,"//button[@class='button button-primary' and text()='Import']").click()
end

When(/^I open the edit page hero image block$/) do
  # Open Hero image block edit table
  find(:xpath, "//li[@title='Add a Hero Image' and contains(@class,'ui-sortable-handle')]").click()
  find(:xpath, "//li[@title='Add a Hero Image' and contains(@class,'ui-sortable-handle')]//a[@class='block-edit']").click()
end

Then(/^I update the picture "([^"]*)" from hero image$/) do |  image |
  # Upload picture to hero block
  find(:xpath, "//div[@aria-hidden='false']//a[@class='aq_upload_button button']").click()
  fill_in_visible_element("//input[@id='media-search-input']", image)
  has_content?('Affichage de 1 médias sur 1')
  click_on_visible_element("//li[@class='attachment save-ready']")
  click_on_visible_element("//button[text()='Sélectionner']")
  sleep 5
end

And(/^I change the hero title by "([^"]*)"$/) do |  title |
  # Change title hero image
  find(:xpath, "//div[@aria-hidden='false']//label[text()='Intensity for Text and ui elements']").visible?
  execute_script("document.querySelector(\"div[aria-hidden='false'] div.sortable-handle a\",':before').click()")
  fill_in("aq_blocks[aq_block_2][tabs][1][title]", with: title)
  fill_in("aq_blocks[aq_block_2][tabs][1][subtitle]", with:  '  ')
  click_on_visible_element("//div[@aria-hidden='false']//button[text()='Done']")
end