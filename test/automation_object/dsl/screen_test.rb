# frozen_string_literal: true
require_relative '../../test_helper'

# Test AutomationObject::Dsl::Screen
class TestDslScreen < Minitest::Test
  def setup
    @blue_prints = AutomationObject::BluePrint.create({ :screens => {:test_screen => {}}})
    @state = AutomationObject::State::Top.new(nil, @blue_prints)
  end

  def test_active?
    screen = AutomationObject::Dsl::ScreenProxy.new(@blue_prints.screens[:test_screen], @state, :test_screen)
    assert_equal false, screen.active?

    @state.screens[:test_screen].active = true
    assert_equal true, screen.active?
  end

  def test_screens
    screen = AutomationObject::Dsl::TopProxy.new(@blue_prints, @state, :top)
    refute_nil screen.test_screen
  end

  def teardown
  end
end