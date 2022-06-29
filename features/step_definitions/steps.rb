

Given(/^I am authorized as "([^"]*)" with password "([^"]*)"$/) do |user, passwd|
  # begin
  #   page.reset!
  # rescue NoMethodError
  #   log 'The browser session could not be cleaned.'
  # ensure
  #   visit Capybara.app_host
  # end
  # next if all(:xpath, "//header//span[text()='#{user}']", wait: 0).any?

  # find(:xpath, "//header//i[@class='fa fa-sign-out']").click if all(:xpath, "//header//i[@class='fa fa-sign-out']", wait: 0).any?


  visit "https://www.photodeuxbulots.com/australia/wp-admin"
  fill_in('user_login', with: user)
  fill_in('user_pass', with: passwd)
  click_button_and_wait('wp-submit', match: :first)
  find(:xpath, "//div[@class='wp-menu-name' and text()='Tableau de bord']").visible?

end


And(/^I upload image from the root "([^"]*)" and folder "([^"]*)"$/) do | root_path, folder |
  visit "https://www.photodeuxbulots.com/australia/wp-admin/media-new.php"
  find(:id, "plupload-browse-button").visible?
  files = Dir.entries("#{root_path}/#{folder}/").select { |f| File.file? File.join("#{root_path}/#{folder}/", f) }
  puts files
  files.each { |file|
    attach_file("#{root_path}/#{folder}/#{file}") do
      find(:id, "plupload-browse-button").click()
    end
    sleep( 3 )
    # find(:xpath, "//button[contains(@data-clipboard-text,'#{file}') and text()='Copier l’URL dans le presse-papiers']",visible).visible?
    copy_button_element= find(:xpath, "//button[contains(@data-clipboard-text,'#{file}') and text()='Copier l’URL dans le presse-papiers']")
    media_element = copy_button_element.ancestor(:id, 'media-items')
    media_element.find(:xpath,"//a[@class='edit-attachment']").click()
    fill_in('attachment_alt', with: File.basename(file, ".*").gsub('_',' '))
    fill_in('attachment_caption', with: folder)
    find(:id,'publish').click()
    click_button('publish')
    has_content?("Fichier média mis à jour.")
    step %(I update picture information "#{file}" and folder "#{folder}")
    sleep(10)
    visit "https://www.photodeuxbulots.com/australia/wp-admin/media-new.php"
    find(:id, "plupload-browse-button").visible?
    #//button[contains(@data-clipboard-text,'virtualizationsles.png') and text()='Copier l’URL dans le presse-papiers']/ancestor::div[@id="media-items"]/
  }
end

And(/^I update picture information "([^"]*)" and folder "([^"]*)"$/) do | root_path, folder |
  fill_in('attachment_alt', with: File.basename(file, ".*").gsub('_',' '))
  fill_in('attachment_caption', with: folder)
  find(:id,'publish').click()
  click_button('publish')
  has_content?("Fichier média mis à jour.")
end

And(/^I get the files name "([^"]*)" and legend "([^"]*)"$/) do | file, folder |
  # root_path = "/home/maxime"
  # folder = "Pictures"
  files = Dir.entries("#{root_path}/#{folder}/")
  puts files
  files.each { |file|
    puts File.basename(file, ".*").gsub('_',' ')
  }
end



# <button type="button" class="button button-small copy-attachment-url" data-clipboard-text="https://www.photodeuxbulots.com/australia/wp-content/uploads/2022/06/virtualizationsles.png">Copier l’URL dans le presse-papiers</button>
#
# Picture need to be modify :
#   Titre => Picture namer => id : attachment-details-two-column-title
#   Legende => Page name / Folder name => attachment-details-two-column-caption