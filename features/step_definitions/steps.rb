

Given(/^I am authorized admin user$/) do
  visit SITE
  fill_in('user_login', with: $website_configuration['website']['admin_login'])
  fill_in('user_pass', with: $website_configuration['website']['admin_password'])
  click_button_and_wait('wp-submit', match: :first)
  find(:xpath, "//div[@class='wp-menu-name' and text()='Tableau de bord']").visible?
end

Then(/^I create a worktype with name "([^"]*)", category parent "([^"]*)" and picture "([^"]*)"$/) do | name, parent_name, image |
  visit "#{SITE}/edit-tags.php?taxonomy=types&post_type=mtheme_portfolio"
  fill_in('tag-name', with: name)
  select(parent_name, from: 'parent')
  find(:xpath, "//a[@id='mtheme_upload_work_image']").click()
  fill_in('media-search-input', with: image)
  # has_content?('Affichage de 1 médias sur 1')
  check_text_present('Affichage de 1 médias sur 1')
  find(:xpath, "//li[@class='attachment save-ready']").click()
  find(:xpath,"//button[text()='Sélectionner']").click()
  click_button('submit')
end

And(/^I register the changes from the block$/) do
  click_on_visible_element("//div[@aria-hidden='false']//button[text()='Done']")
end

And(/^I publish the page$/) do
  click_on_visible_element("//input[@id='publish']")
end

#  Amazon Linux test
# And(/^ "([^"]*)"$/) do | |
