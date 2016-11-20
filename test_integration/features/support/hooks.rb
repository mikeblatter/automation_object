# Set up Java Drivers
drivers_path = File.expand_path(File.join(__dir__, 'drivers/'))
ENV['SELENIUM_SERVER_JAR'] = drivers_path
ENV['PATH'] = "#{drivers_path}:" + ENV['PATH']

require_relative '../../../lib/automation_object'

driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = 3 # seconds

at_exit {
  begin
    driver.quit
  rescue Exception => e
    ap e
  end
}

AutomationObject::Framework.new(driver: driver, blue_prints: File.expand_path(File.join(__dir__, '../../blue_prints')))

#Load Cucumber Step Definitions
AutomationObject::StepDefinitions.load