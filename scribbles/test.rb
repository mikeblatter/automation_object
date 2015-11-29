require_relative '../lib/automation_object'

driver = Selenium::WebDriver.for :chrome

at_exit {
  driver.quit
}

options = {
    blue_prints: File.join(File.expand_path(__dir__), 'test_blueprints/'),
    driver: driver
}

return if blue_prints.screens == nol
blue_prints.screens



dsl_api = AutomationObject::Framework.new(options)

ap dsl_api.home_screen

dsl_api.quit

=begin
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
=end