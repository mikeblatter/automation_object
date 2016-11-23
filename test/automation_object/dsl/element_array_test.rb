# frozen_string_literal: true
require_relative '../../test_helper'

# Test AutomationObject::Dsl::ElementArray
class TestDslElementArray < Minitest::Test
  def setup
    @blue_prints = stub()
    @state = stub(:active? => true)
  end

  def teardown
  end

  def test_active?
    dsl = AutomationObject::Dsl::ElementArrayProxy.new(@blue_prints, @state, :test)
    assert_equal true, dsl.active?
  end
end