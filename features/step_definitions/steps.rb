## -------------------------------------------
#
# common steps
#
## -------------------------------------------

Given(/^I am authorized admin user$/) do
  visit SITE
  fill_in('user_login', with: $admin)
  fill_in('user_pass', with: $password)
  click_button_and_wait('wp-submit', match: :first)
  find(:xpath, "//div[@class='wp-menu-name' and text()='Tableau de bord']").visible?
end

And(/^I register the changes from the block$/) do
  click_on_first_visible_element("//div[@aria-hidden='false']//button[text()='Done']")
end

And(/^I publish the ([^"]*)$/) do | type |
  click_on_first_visible_element("//input[@id='publish']")
  check_text_present(EXPECTED_PUBLISH_TEXT[type])
end

And(/^I logout$/) do
  logout= find(:xpath, "//li[@id='wp-admin-bar-logout']//a[text()='Se déconnecter']", visible: :all)[:href]
  visit logout
end

And(/^I select the first image$/) do
  find(:xpath, "//li[@class='attachment save-ready']", match: :first).click
end