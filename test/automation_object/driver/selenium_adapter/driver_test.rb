require_relative '../../../test_helper'

require_relative '../../../../lib/automation_object/driver/selenium_adapter/driver'
require_relative '../../../../lib/automation_object/driver/driver'

#Test AutomationObject::Driver::NokogiriAdapter::Driver class
class TestSeleniumAdapterDriver < Minitest::Test
  def setup
  end

  #Nokogiri Driver should have all Driver interface methods
  #Use reflection to add multiple test functions so we can capture each failure
  AutomationObject::Driver::Driver.public_instance_methods(false).each do |method|
    define_method("test_interface_#{method}") do
      assert AutomationObject::Driver::SeleniumAdapter::Driver.public_instance_methods.include?(method),
             "AutomationObject::Driver::SeleniumAdapter::Driver should have instance method: #{method}"
    end
  end
end