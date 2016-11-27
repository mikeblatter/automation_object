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

blue_prints_path = File.expand_path(File.join(__dir__, '../../blue_prints'))

# Create Framework
AutomationObject::Framework.new(driver, blue_prints_path)

# Load Cucumber Step Definitions
AutomationObject::StepDefinitions.load