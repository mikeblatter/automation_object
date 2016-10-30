# frozen_string_literal: true
require_relative '../driver_adapter_test_helper'

# Test AutomationObject::Driver::AppiumAdapter::Driver class
class TestAppiumAdapterDriver < Minitest::Test
  include DriverAdapterTestHelper

  self.interface_class = AutomationObject::Driver::Driver
  self.adapter_class = AutomationObject::Driver::AppiumAdapter::Driver

  create_tests

  def setup
  end
end
