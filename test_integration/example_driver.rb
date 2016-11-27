# Set up Java Drivers
drivers_path = File.expand_path(File.join(__dir__, 'drivers/'))

ENV['SELENIUM_SERVER_JAR'] = drivers_path
ENV['PATH'] = "#{drivers_path}:" + ENV['PATH']

require 'pry'
require_relative '../lib/automation_object'

driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = 3 # seconds

at_exit {
  driver.quit
}

# Allow user to debug using pry
binding.pry


