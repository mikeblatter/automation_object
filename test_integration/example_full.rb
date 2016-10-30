# PRY
require 'pry'

#Require framework
require_relative '../lib/automation_object'

#Using to simulate simple website
require_relative 'rails_app'

drivers_path = File.expand_path(File.join(__dir__, 'drivers/'))
ENV['SELENIUM_SERVER_JAR'] = drivers_path
ENV['PATH'] = "#{drivers_path}:" + ENV['PATH']

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

ao = AutomationObject::Framework.new(driver, File.expand_path(File.join(__dir__, 'blue_prints/')))

# Allow user to debug using pry
binding.pry