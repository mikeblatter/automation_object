# frozen_string_literal: true
require_relative '../driver_adapter_test_helper'

# Test AutomationObject::Driver::NokogiriAdapter::Element class
class TestSeleniumAdapterElement < Minitest::Test
  include DriverAdapterTestHelper

  self.interface_class = AutomationObject::Driver::Element
  self.adapter_class = AutomationObject::Driver::SeleniumAdapter::Element

  create_tests

  def setup
  end
end
