require_relative '../lib/automation_object'

ao = AutomationObject::Framework.new(nil, File.expand_path(File.join(__dir__, 'page_object_blueprints/')))

#100.times do
#  ao.home_screen.contact_button.click
#  ao.contact_screen.home_button.click
#end

# Allow user to debug using pry
binding.pry