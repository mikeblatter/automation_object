# frozen_string_literal: true

require_relative '../test_helper'
automation_object_require 'version'

# Test Framework class
class TestAutomationObject < Minitest::Test
  def setup; end

  def test_version
    refute_nil AutomationObject::VERSION
  end
end
