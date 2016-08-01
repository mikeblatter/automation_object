require_relative '../adapter_test_helper'

#Test AutomationObject::Driver::NokogiriAdapter::Driver class
class TestSeleniumAdapterDriver < Minitest::Test
  include AdapterTestHelper

  self.interface_class = AutomationObject::Driver::Driver
  self.adapter_class = AutomationObject::Driver::SeleniumAdapter::Driver

  create_tests()

  def setup
  end
end