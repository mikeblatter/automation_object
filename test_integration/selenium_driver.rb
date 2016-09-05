#Require framework
require_relative '../lib/automation_object'

driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = 3 # seconds

at_exit {
  driver.quit
}

loop do
  puts 'Execute CMD (exit to quit): '
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





