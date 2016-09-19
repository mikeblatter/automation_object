# frozen_string_literal: true
require_relative '_base'

# Test AutomationObject::BluePrint::HashAdapter::Top < Composite
class TestHashAdapterTop < Minitest::Test
  include HashAdapterBase

  self.interface_class = AutomationObject::BluePrint::Composite::Top
  self.adapter_class = AutomationObject::BluePrint::HashAdapter::Top
  self.defaults = {
    base_url: nil,
    default_screen: nil,
    screen_transition_sleep: 0,
    screens: {},
    throttle_driver_methods: {},
    throttle_element_methods: {}
  }

  create_tests

  def test_base_url
    composite = create_composite(base_url: 'test_url')
    assert_equal 'test_url', composite.base_url
  end

  def test_default_screen_string
    composite = create_composite(default_screen: 'test_screen')
    assert_equal :test_screen, composite.default_screen
  end

  def test_default_screen_symbol
    composite = create_composite(default_screen: :test_screen)
    assert_equal :test_screen, composite.default_screen
  end

  def test_screen_transition_sleep_integer
    composite = create_composite(screen_transition_sleep: 1)
    assert_equal 1, composite.screen_transition_sleep
  end

  def test_screen_transition_sleep_float
    composite = create_composite(screen_transition_sleep: 0.5)
    assert_equal 0.5, composite.screen_transition_sleep
  end

  def test_screens
    composite = create_composite(screens: { test_screen_one: {}, test_screen_two: {} })

    assert_instance_of Hash, composite.screens
    composite.screens.each do |screen_name, screen_composite|
      assert_includes [:test_screen_one, :test_screen_two], screen_name
      assert_instance_of AutomationObject::BluePrint::Composite::Screen, screen_composite
    end
  end

  def test_throttle_driver_methods
    hash = { test: 1 }

    composite = create_composite(throttle_driver_methods: hash)
    assert_equal hash, composite.throttle_driver_methods
  end

  def test_throttle_element_methods
    hash = { test: 1 }

    composite = create_composite(throttle_element_methods: hash)
    assert_equal hash, composite.throttle_element_methods
  end
end
