require_relative '../lib/automation_object'

AutomationObject::Driver.adapter = :nokogiri
driver = AutomationObject::Driver.new

driver.get('http://www.dose.com')
driver.get('http://www.dose.com/privacypolicy')

driver.navigate.back
driver.find_element(:xpath, '//footer//nav/ul/li/a').click

ap driver.current_url
ap driver.window_handles
ap driver.window_handle
puts 'closing'.colorize(:magenta)
driver.close
ap driver.current_url
ap driver.window_handle
ap driver.window_handles