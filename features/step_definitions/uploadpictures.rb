## -------------------------------------------
#
# upload pictures steps
#
## -------------------------------------------

When(/^I get the images list$/) do
  $images = Dir.entries($website_configuration['environment']['root']).select { |f| File.file? File.join($website_configuration['environment']['root'], f) }
  # $images.each { |image|
  #   element =  image.gsub("'", "\\'")
  #   puts "test '#{%(element)})}'"
  # }
end

Then(/^I upload all the images to the web site and update there legend$/) do
  legend = $website_configuration['image_import']['legend']
  puts "The legend name '#{legend}' will be used for all this pictures"
  $images.each { |image|
    step %(I upload "#{image}" image with the legend "#{legend}")
  }
end

And(/^I upload "([^"]*)" image with the legend "([^"]*)"$/) do |image, legend|
  # Open the upload page
  visit "#{SITE}/media-new.php"

  # Add picture to website
  attach_file("#{$website_configuration['environment']['root']}/#{image}") do
    find(:id, "plupload-browse-button").click
  end
  expected_value = File.basename(image, ".*")
  copy_button_element = find(:xpath, "//div[@class='filename new']/span[@class='title' and text()=\"#{expected_value}\"]")
  media_element = copy_button_element.ancestor(:xpath, "//div[contains(@class,'media-item')]")
  new_page = media_element.find(:xpath, "//a[@class='edit-attachment']")[:href]
  visit new_page

  step %(I update "#{image}" picture information with legend "#{legend}")
end

And(/^I update "([^"]*)" picture information with legend "([^"]*)"$/) do |image, folder|
  fill_in('attachment_alt', with: File.basename(image, ".*").gsub('_', ' '))
  fill_in('attachment_caption', with: folder)
  find(:id, 'publish').click
  step %(I publish the media)
end