

Given(/^I am authorized admin user$/) do
  visit SITE
  fill_in('user_login', with: $website_configuration['website']['admin_login'])
  fill_in('user_pass', with: $website_configuration['website']['admin_password'])
  click_button_and_wait('wp-submit', match: :first)
  find(:xpath, "//div[@class='wp-menu-name' and text()='Tableau de bord']").visible?
end

And(/^I register the changes from the block$/) do
  click_on_visible_element("//div[@aria-hidden='false']//button[text()='Done']")
end

And(/^I publish the page$/) do
  click_on_visible_element("//input[@id='publish']")
end

#  Amazon Linux test
# And(/^ "([^"]*)"$/) do | |
