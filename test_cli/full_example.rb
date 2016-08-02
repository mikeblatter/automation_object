#Require framework
require_relative '../lib/automation_object'

#Using to simulate simple website
require_relative 'rails_app'

puts "- Can operate on the variable ao for AutomationObject or driver for selenium driver"
puts "- Example: ao.home_screen.logo_button"
puts "- Wait for first ask to run command"
puts "----------------------------------------------------"

rails_app = RailsApp.new

driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = 3 # seconds

at_exit {
  driver.quit
}

ao = AutomationObject::Framework.new(driver, File.expand_path(File.join(__dir__, 'blue_prints/')))

loop do
  print 'Execute CMD (exit to quit): '
  command = gets
  if command.match(/exit/) or command.match(/quit/)
    break
  end

  begin
    ap eval(command)
  rescue Exception => e
    ap e
    puts e.backtrace
  end
end









