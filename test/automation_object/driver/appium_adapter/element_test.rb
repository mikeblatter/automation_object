# frozen_string_literal: true
require_relative '../adapter_test_helper'

# Test AutomationObject::Driver::AppiumAdapter::Element class
class TestAppiumAdapterElement < Minitest::Test
  include AdapterTestHelper

  self.interface_class = AutomationObject::Driver::Element
  self.adapter_class = AutomationObject::Driver::AppiumAdapter::Element

  create_tests

  def setup
  end
end
