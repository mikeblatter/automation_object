# frozen_string_literal: true
require_relative '../test_helper'

# Test Framework class
class TestAutomationObject < Minitest::Test
  def setup
  end

  def test_version
    refute_nil AutomationObject::VERSION
  end
end
