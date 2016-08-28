#Require framework
require_relative '../lib/automation_object'

#Using to simulate simple website
require_relative 'rails_app'

drivers_path = File.expand_path(File.join(__dir__, 'drivers/'))
ENV['SELENIUM_SERVER_JAR'] = drivers_path
ENV['PATH'] = "#{drivers_path}:" + ENV['PATH']

puts "- Can operate on the variable ao for AutomationObject or driver for selenium driver"
puts "- Example: ao.home_screen.logo_button"
puts "- Wait for first ask to run command"
puts "----------------------------------------------------"

#Just create, will destroy automatically
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

loop do
  print 'Execute CMD (exit to quit): '
  command = gets
  if command.match(/exit/) or command.match(/quit/)
    break
  end

  begin
    ap eval(command), :limit => 3
  rescue Exception => e
    ap e
    puts e.backtrace
  end
end
