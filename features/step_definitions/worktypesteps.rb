## -------------------------------------------
#
# create work type steps
#
## -------------------------------------------

When(/^I open work type create page$/) do
  visit "#{SITE}/edit-tags.php?taxonomy=types&post_type=mtheme_portfolio"
end

Then(/^I change the work type name$/) do
  fill_in('tag-name', with: $website_configuration['work_type']['name'])
end

And(/^I update the slug field$/) do
  fill_in('tag-slug', with: $website_configuration['work_type']['slug'])
end

And(/^I select the work type parent category$/) do
  select($website_configuration['work_type']['parent'], from: 'parent')
end

And(/^I update the work type description field$/) do
  fill_in('tag-description', with: $website_configuration['work_type']['description'])
end

And(/^I choose the work type image$/) do
  find(:xpath, "//a[@id='mtheme_upload_work_image']").click
  fill_in('media-search-input', with: $website_configuration['work_type']['image'])
  wait_spinner
  step %(I select the first image)
  find(:xpath, "//button[text()='Sélectionner']").click
end

And(/^I register the work type changes$/) do
  click_button('submit')
end
