## -------------------------------------------
#
# page tab steps
#
## -------------------------------------------

When(/^I go to page tab$/) do
  visit "#{SITE}/edit.php?post_type=page"
end

Then(/^I select the main gallery$/) do
  fill_in('post-search-input', with: $website_configuration['gallery']['name'])
  click_on_first_visible_element("//input[@id='search-submit']")
  click_on_first_visible_element("//a[contains(text(),'#{$website_configuration['gallery']['name']}')]")
end

And(/^I open the portfolio grid$/) do
  find(:xpath, "//li[@title='Generate a Portfolio Grid' and contains(@class,'ui-sortable-handle')]").click
  find(:xpath, "//li[@title='Generate a Portfolio Grid' and contains(@class,'ui-sortable-handle')]//a[@class='block-edit']").click
end

And(/^I add the work type to list$/) do
  work_type_list_element = "//input[@id='aq_block_8_mtheme_worktype_slugs']"
  current_values = find(:xpath, work_type_list_element)['value']
  new_value = "#{current_values},#{$website_configuration['work_type']['slug']}"
  fill_in_visible_element(work_type_list_element, new_value)
end
