

def click_button_and_wait(locator = nil, **options)
  click_button(locator, options)
  begin
    raise 'Timeout: Waiting AJAX transition (click link)' unless has_no_css?('.senna-loading', wait: 5)
  rescue StandardError, Capybara::ExpectationNotMet => e
    STDOUT.puts e.message # Skip errors related to .senna-loading element
  end
end


def click_on_first_visible_element(xpath)
  modify_xpath = xpath.delete_suffix("]")
  find(:xpath, "#{modify_xpath} #{VISIBLE_ELEMENT}]", match: :first).click()
end

def fill_in_visible_element(xpath, text)
  modify_xpath = xpath.delete_suffix("]")
  find(:xpath, "#{modify_xpath} #{VISIBLE_ELEMENT}]").fill_in with: text
end

def check_text_present(text)
  raise 'Text not found' unless has_text?(text)
end

def check_element_present(xpath)
  find(:xpath, xpath)
end

def wait_spinner
  unless page.all(:xpath, "//div[@class='media-modal-content']//span[@class='spinner is-active']", visible: true, wait: 1).empty?
    find(:xpath, "//div[@class='media-modal-content']//span[@class='spinner is-active']", visible: false)
  end
end

def get_duplicate(list)
  duplicate_element = list.find_all { |ip| list.count(ip) > 1 }

  unique_duplicate_element = []
  duplicate_element.each { |duplicate|
    unless unique_duplicate_element.include?(duplicate)
      unique_duplicate_element << duplicate
    end
  }
  return unique_duplicate_element
end
