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
  click_on_visible_element("//div[@aria-hidden='false']//button[text()='Done']")
end

And(/^I publish the page$/) do
  click_on_visible_element("//input[@id='publish']")
  check_text_present('Page mise à jour.')
end

And(/^I update the page$/) do
  click_on_visible_element("//input[@id='publish']")
  check_text_present('Article mis à jour.')
end

And(/^I logout$/) do
  logout= find(:xpath, "//li[@id='wp-admin-bar-logout']//a[text()='Se déconnecter']", visible: :all)[:href]
  visit logout
end

And(/^I select the first image$/) do
  find(:xpath, "//li[@class='attachment save-ready']", match: :first).click
end