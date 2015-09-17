require_relative '../lib/automation_object'

raw_driver = Selenium::WebDriver.for :chrome

AutomationObject::Driver.adapter = :selenium
driver = AutomationObject::Driver.new(raw_driver)

begin
  loop do
    puts 'Input the command you would like to execute'
    input = gets
    input = input.strip

    begin
      ap eval(input)
    rescue Exception => e
      puts 'Error occurred'.colorize(:red)
      ap e
      ap e.class
      ap e.message
      ap e.backtrace
    end
  end
ensure
  puts 'Press enter to quit'
  input = gets

  driver.quit
end