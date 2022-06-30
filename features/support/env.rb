require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'rspec'
require 'yaml'

Capybara.run_server = false
Capybara.default_max_wait_time = 20
#Set default driver as Selenium
Capybara.default_driver = :selenium
#Set default selector as css
Capybara.default_selector = :id
#Syncronization related settings
module Helpers
  def without_resynchronize
    page.driver.options[:resynchronize] = false
    yield
    page.driver.options[:resynchronize] = true
  end
end
World(Capybara::DSL, Helpers)

Capybara.ignore_hidden_elements = true

$website_configuration = YAML.load_file('configuration.yaml')
