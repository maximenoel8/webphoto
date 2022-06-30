

def click_button_and_wait(locator = nil, **options)
  click_button(locator, options)
  begin
    raise 'Timeout: Waiting AJAX transition (click link)' unless has_no_css?('.senna-loading', wait: 5)
  rescue StandardError, Capybara::ExpectationNotMet => e
    STDOUT.puts e.message # Skip errors related to .senna-loading element
  end
end


def click_on_visible_element(xpath)
  modify_xpath = xpath.delete_suffix("]")
  find(:xpath, "#{modify_xpath} #{VISIBLE_ELEMENT}]").click()
end

def fill_in_visible_element(xpath, text)
  modify_xpath = xpath.delete_suffix("]")
  find(:xpath, "#{modify_xpath} #{VISIBLE_ELEMENT}]").fill_in with: text
end