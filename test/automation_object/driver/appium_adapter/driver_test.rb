require_relative '../adapter_test_helper'

# Test AutomationObject::Driver::AppiumAdapter::Driver class
class TestAppiumAdapterDriver < Minitest::Test
  include AdapterTestHelper

  self.interface_class = AutomationObject::Driver::Driver
  self.adapter_class = AutomationObject::Driver::AppiumAdapter::Driver

  create_tests()

  def setup
  end
end
