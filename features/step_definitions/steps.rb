

Given(/^I am authorized as "([^"]*)" with password "([^"]*)"$/) do |user, passwd|
  visit "https://www.photodeuxbulots.com/australia/wp-admin"
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
  visit "https://www.photodeuxbulots.com/australia/wp-admin/media-new.php"

  # Add picture to website
  attach_file("#{root_path}/#{folder}/#{image}") do
    find(:id, "plupload-browse-button").click()
  end
  find(:xpath, "//button[contains(@data-clipboard-text,'#{image}') and text()='Copier l’URL dans le presse-papiers']").visible?
  # Make sure we modify the correct element by selecting it with ancestor
  copy_button_element= find(:xpath, "//button[contains(@data-clipboard-text,'#{image}') and text()='Copier l’URL dans le presse-papiers']")
  media_element = copy_button_element.ancestor(:id, 'media-items')
  media_element.find(:xpath,"//a[@class='edit-attachment']").click()

  step %(I update "#{image}" picture information with legend "#{folder}")
end

And(/^I update "([^"]*)" picture information with legend "([^"]*)"$/) do | image, folder |
  fill_in('attachment_alt', with: File.basename(image, ".*").gsub('_',' '))
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