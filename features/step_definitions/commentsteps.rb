## -------------------------------------------
#
# comment page  steps
#
## -------------------------------------------

When(/^I open the comments page$/) do
  visit "#{SITE}/edit-comments.php?comment_status=moderated"
end

And(/^I get the number of comment's pages$/) do
  $number_pages = find(:xpath, "//span[@class='total-pages']", match: :first).text.to_i
  puts $number_pages
end

And(/^I get the comments ip list in on page$/) do
  comment_rows = page.all(:xpath, "//tr[contains(@class,'comment') and contains(@class,'unapproved')]")
  comment_rows.each { |comment|
    #ip address element
    $ips << comment.find(:xpath, ".//td[@class='author column-author']/a[contains(@href,'mode=detail')]").text
  }
end

And(/^I get the ip list of all the pages$/) do
  step %(I get the number of comment's pages)
  page_number = 1
  $ips = []
  while page_number <= $number_pages
    page_number += 1
    step %(I get the comments ip list in on page)
    # step %(I check the comment language)
    if page_number < $number_pages
      click_on_first_visible_element("//a[@class='next-page']")
      expect(page).to have_current_path("#{SITE}/edit-comments.php?comment_status=moderated&paged=#{page_number}")
    end
  end
  puts "Method 2:\n #{get_duplicate($ips)}"
end

And(/^I delete comment in ([^"]*) language$/) do |deleted_language|
  wl = WhatLanguage.new(:all)
  comment_rows = page.all(:xpath, "//tr[contains(@class,'comment') and contains(@class,'unapproved')]")
  comment_rows.each { |comment|
    comment_language = wl.language(comment.find(:xpath, ".//td[@class='comment column-comment has-row-actions column-primary']/p", match: :first).text)
    if comment_language == deleted_language
      comment.find(:xpath, ".//td[@class='comment column-comment has-row-actions column-primary']").click
      comment.find(:xpath, ".//td[@class='comment column-comment has-row-actions column-primary']/div[@class='row-actions']/span[@class='trash']").click
    end
  }

end

And(/^I block duplicate ([^"]*)$/) do |ip|

  click_on_first_visible_element("//a[@data-value='ip-address']")
  fill_in('wf-block-ip', with: ip)
  fill_in('wf-block-reason', with: 'spam - automatic ip match')
  click_on_first_visible_element("//a[@id='wf-block-add-save']")
  block_subpage = find(:id, 'wf-blocks-wrapper')
  expect(block_subpage).to have_text("#{ip}")
end

And(/^I block all the duplicate IPs$/) do
  visit "#{SITE}/admin.php?page=WordfenceWAF#top#blocking"
  ips = %w[45.152.208.239 45.92.247.207 185.250.39.125 45.94.47.151 45.130.255.62 182.54.239.93 45.155.70.26 185.250.39.247 45.152.202.103 45.8.134.182 185.126.65.17 45.142.28.79 185.164.56.67 45.130.60.204 185.95.157.37 185.126.65.12 182.54.239.56 45.142.28.33 45.152.202.230 45.137.40.125 45.86.15.129 182.54.239.11 185.164.56.233 45.87.248.76 45.154.56.154 193.8.94.245 45.130.60.114 45.86.15.229 2.56.101.27 45.86.15.69 45.152.202.19 45.137.60.125 45.140.14.186 182.54.239.221 185.205.194.117 2.59.21.219 45.137.84.188 182.54.239.1 185.95.157.156 45.130.60.219 144.168.210.89 45.137.43.216 45.152.208.204 182.54.239.203 182.54.239.119 45.130.255.47 193.8.94.246 45.130.60.251 209.127.164.113 45.130.255.46 2.59.21.136 2.56.101.159 45.137.43.241 45.154.84.126 45.92.247.32 45.130.255.175 45.87.249.68 45.145.56.247 45.92.247.130 2.59.21.149 45.158.185.41 45.86.15.48 45.9.122.203 185.95.157.96 45.9.122.163 45.92.247.214 193.8.94.118 185.250.39.186 45.134.187.54 45.136.228.2 23.236.222.253 2.56.101.236 45.136.231.66 45.152.202.228 45.136.231.60 2.56.101.232 193.8.215.0 182.54.239.65 45.136.231.4 45.136.231.23 23.229.122.77 45.9.122.232 194.105.60.210 185.95.157.180 193.8.56.68 45.94.46.141 45.137.195.108 45.142.28.62 45.130.60.163 45.155.70.89 45.154.84.104 45.87.249.16 45.92.247.67 45.137.40.58 185.95.157.178 195.154.182.201 94.172.222.145 31.132.220.2 5.188.48.16 193.8.231.223 206.123.139.230 45.57.255.105 209.127.143.238 188.126.94.57 83.221.222.94 188.126.94.125 51.158.153.225 31.132.211.144 196.52.84.7 196.52.84.35 151.106.54.34 196.52.84.17 196.52.84.15 196.52.84.25 145.255.21.66 46.0.203.99 5.188.84.150 62.210.79.40 185.230.124.53 92.223.89.137 194.187.249.34 134.119.195.38 194.99.104.26 46.243.220.103 91.122.30.68 37.104.248.210 94.156.35.59 5.188.84.76 5.188.211.100 46.166.142.217 193.233.158.136 182.50.255.210 68.234.46.56 206.198.219.114 185.253.96.17 5.188.84.130]
  ips.each { |ip|
    step %(I block duplicate #{ip})
  }
end

And(/^I delete the comment if it's ([^"]*)$/) do |language|

end
# And(/^$/) do
# And(/^$/) do
# And(/^$/) do