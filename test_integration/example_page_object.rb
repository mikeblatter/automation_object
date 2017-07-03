# Set up Java Drivers
drivers_path = File.expand_path(File.join(__dir__, 'drivers/'))
ENV['SELENIUM_SERVER_JAR'] = drivers_path
ENV['PATH'] = "#{drivers_path}:" + ENV['PATH']

require 'pry'
require_relative 'rails_app'
require_relative '../lib/automation_object'

# Create new rails app, self cleaning on exit
RailsApp.new

driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = 3 # seconds

at_exit {
  begin
    driver.quit
  rescue Exception => e
    ap e
  end
}

ao = AutomationObject::Framework.new(driver, File.expand_path(File.join(__dir__, 'page_object_blueprints/')))

#100.times do
#  ao.home_screen.contact_button.click
#  ao.contact_screen.home_button.click
#end

# Allow user to debug using pry
binding.pry