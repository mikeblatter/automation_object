require_relative '../lib/automation_object'

raw_driver = Selenium::WebDriver.for :chrome

ao = AutomationObject::Framework.new(driver: raw_driver,
                                         blue_prints: File.expand_path(File.join(__dir__, 'test_blueprints/')))

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

  raw_driver.quit
end
