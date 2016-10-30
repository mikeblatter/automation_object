# PRY
require 'pry'

#Require framework
require_relative '../lib/automation_object'

driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = 3 # seconds

at_exit {
  driver.quit
}

# Allow user to debug using pry
binding.pry


