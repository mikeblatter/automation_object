# frozen_string_literal: true
require_relative '../adapter_test_helper'

# Test AutomationObject::Driver::NokogiriAdapter::Driver class
class TestNokogiriAdapterDriver < Minitest::Test
  include AdapterTestHelper

  self.interface_class = AutomationObject::Driver::Driver
  self.adapter_class = AutomationObject::Driver::NokogiriAdapter::Driver

  create_tests

  def setup
  end
end
