# frozen_string_literal: true
require_relative '../../test_helper'

# Test AutomationObject::Dsl::Modal
class TestDslModal < Minitest::Test
  def setup
    @blue_print = AutomationObject::BluePrint.create({ :screens => {:home_screen => {}}})
    @state = stub(:screens => {})
  end

  def test_active?
    top = AutomationObject::Dsl::TopProxy.new(@blue_print, @state, :top)
    assert_equal true, top.active?
  end

  def test_screens
    top = AutomationObject::Dsl::TopProxy.new(@blue_print, @state, :top)
    refute_nil top.home_screen
  end

  def teardown
  end
end