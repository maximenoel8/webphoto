

Given(/^I am authorized as "([^"]*)" with password "([^"]*)"$/) do |user, passwd|
  visit SITE
  fill_in('user_login', with: user)
  fill_in('user_pass', with: passwd)
  click_button_and_wait('wp-submit', match: :first)
  find(:xpath, "//div[@class='wp-menu-name' and text()='Tableau de bord']").visible?
end

And(/^I upload all the images from the root "([^"]*)" and folder "([^"]*)"$/) do | root_path, folder |
  images = Dir.entries("#{root_path}/#{folder}/").select { |f| File.file? File.join("#{root_path}/#{folder}/", f) }
  puts images
  images.each { |image|
    step %(I upload "#{image}" image from the root "#{root_path}" and folder "#{folder}")
  }
end

And(/^I upload "([^"]*)" image from the root "([^"]*)" and folder "([^"]*)"$/) do | image, root_path, folder |
  # Open the upload page
  visit "#{SITE}/media-new.php"

  # Add picture to website
  attach_file("#{root_path}/#{folder}/#{image}") do
    find(:id, "plupload-browse-button").click()
  end
  # find(:xpath, "//button[contains(@data-clipboard-text,'#{image}') and text()='Copier l’URL dans le presse-papiers']").visible?
  # Make sure we modify the correct element by selecting it with ancestor
  # copy_button_element= find(:xpath, "//button[contains(@data-clipboard-text,'#{image}') and text()='Copier l’URL dans le presse-papiers']")
  expected_value = File.basename(image, ".*")
  copy_button_element = find(:xpath, "//div[@class='filename new']/span[@class='title' and text()='#{expected_value}']")
  media_element = copy_button_element.ancestor(:xpath, "//div[contains(@class,'media-item')]")
  new_page = media_element.find(:xpath,"//a[@class='edit-attachment']")[:href]
  visit new_page

  step %(I update "#{image}" picture information with legend "#{folder}")
end

And(/^I update "([^"]*)" picture information with legend "([^"]*)"$/) do | image, folder |
  fill_in('attachment_alt', with: File.basename(image, ".*").gsub('_',' '))
  fill_in('attachment_caption', with: folder)
  find(:id,'publish').click()
  click_button('publish')
  has_content?("Fichier média mis à jour.")
end

Then(/^I create a worktype with name "([^"]*)", category parent "([^"]*)" and picture "([^"]*)"$/) do | name, parent_name, image |
  visit "#{SITE}/edit-tags.php?taxonomy=types&post_type=mtheme_portfolio"
  fill_in('tag-name', with: name)
  select(parent_name, from: 'parent')
  find(:xpath, "//a[@id='mtheme_upload_work_image']").click()
  fill_in('media-search-input', with: image)
  has_content?('Affichage de 1 médias sur 1')
  find(:xpath, "//li[@class='attachment save-ready']").click()
  find(:xpath,"//button[text()='Sélectionner']").click()
  click_button('submit')
end


And(/^I create a new project item with title "([^"]*)" link to worktype "([^"]*)" and picture "([^"]*)"$/) do | title, worktype, image |
  visit "#{SITE}/post-new.php?post_type=mtheme_portfolio"
  fill_in('title', with: title)
  find(:xpath, "//label[@class='selectit' and contains(.,'#{worktype}')]").click()
  find(:xpath,"//span[@class='mtheme-pb-choice mtheme-pb-yes']").click()
  has_content?('Using Page Builder.')
  #clear
  find(:xpath,"//a[@class='emptyTemplates']").click()

  #import block
  find(:id,'import-a-block').click()
  find(:xpath,"//div[@id='mtheme-pb-import-a-block']//textarea").fill_in with: BLOCK_IMPORT
  find(:xpath,"//button[@class='button button-primary' and text()='Import']").click()

  # Open Hero image block edit table
  # has_xpath?("//li[@title='Add a Hero Image']")
  find(:xpath, "//li[@title='Add a Hero Image' and contains(@class,'ui-sortable-handle')]").click()
  find(:xpath, "//li[@title='Add a Hero Image' and contains(@class,'ui-sortable-handle')]//a[@class='block-edit']").click()
  sleep 5

  step %(I update the picture "#{image}" from hero image")
  step %(I change the hero title by "#{title}")

  find(:xpath, "//img[@data-value='edge-to-edge']")
  sleep 5

end


And(/^I update the picture "([^"]*)" from hero image"$/) do |  image |
  # Upload picture to hero block
  find(:xpath, "//div[@aria-hidden='false']//a[@class='aq_upload_button button']").click()
  fill_in_visible_element("//input[@id='media-search-input']", image)
  has_content?('Affichage de 1 médias sur 1')
  click_on_visible_element("//li[@class='attachment save-ready']")
  click_on_visible_element("//button[text()='Sélectionner']")
  sleep 5
end

And(/^I change the hero title by "([^"]*)""$/) do |  title |
  # Change title hero image
  find(:xpath, "//div[@aria-hidden='false']//label[text()='Intensity for Text and ui elements']").visible?
  execute_script("document.querySelector(\"div[aria-hidden='false'] div.sortable-handle a\",':before').click()")
  fill_in("aq_blocks[aq_block_2][tabs][1][title]", with: title)
  fill_in("aq_blocks[aq_block_2][tabs][1][subtitle]", with:  '  ')
  click_on_visible_element("//div[@aria-hidden='false']//button[text()='Done']")
end
#  Amazon Linux test
