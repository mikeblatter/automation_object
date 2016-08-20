#Require framework
require_relative '../../../lib/automation_object'

#Using to simulate simple website
require_relative '../../rails_app'

#Create local rails service
@rails_app = RailsApp.new
@rails_app.create

#Create driver
@driver = Selenium::WebDriver.for :chrome
@driver.manage.timeouts.implicit_wait = 3 # seconds
at_exit {
  @driver.quit
}

#Set Automation object to instance variable
@automation_object = AutomationObject::Framework.new(driver: @driver,
                                     blue_prints: File.expand_path(File.join(__dir__, '../../blue_prints')))

#Load Cucumber Step Definitions
AutomationObject::StepDefinitions.load