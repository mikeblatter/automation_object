require_relative '../adapter_test_helper'

# Test AutomationObject::Driver::NokogiriAdapter::Element class
class TestSeleniumAdapterElement < Minitest::Test
  include AdapterTestHelper

  self.interface_class = AutomationObject::Driver::Element
  self.adapter_class = AutomationObject::Driver::SeleniumAdapter::Element

  create_tests()

  def setup
  end
end
