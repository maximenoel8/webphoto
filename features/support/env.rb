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
Capybara.ignore_hidden_elements = true
module Helpers
  def without_resynchronize
    page.driver.options[:resynchronize] = false
    yield
    page.driver.options[:resynchronize] = true
  end
end
World(Capybara::DSL, Helpers)

login_information = YAML.load_file('login.yaml')
$admin = login_information['website']['admin_login']
$password = login_information['website']['admin_password']

$website_configuration = YAML.load_file('configuration.yml')
