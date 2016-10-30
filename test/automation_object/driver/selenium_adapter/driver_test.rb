# frozen_string_literal: true
require_relative '../driver_adapter_test_helper'

# Test AutomationObject::Driver::NokogiriAdapter::Driver class
class TestSeleniumAdapterDriver < Minitest::Test
  include DriverAdapterTestHelper

  self.interface_class = AutomationObject::Driver::Driver
  self.adapter_class = AutomationObject::Driver::SeleniumAdapter::Driver

  create_tests

  def setup
  end
end
