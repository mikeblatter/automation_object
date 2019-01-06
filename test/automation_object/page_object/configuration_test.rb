# frozen_string_literal: true

require_relative '../../test_helper'

require_relative '../../../lib/automation_object/page_object/configuration'


class ConfigurationStub < AutomationObject::PageObject::Configuration
  base_url 'http://test.com'
  default_screen 'test'
  screen_transition_sleep 1

  throttle_driver_methods ({
      :find_element => 1,
  })

  throttle_element_methods ({
      :click => 1,
  })
end


class TestPageObjectConfiguration < Minitest::Test
  def test_base_url
    assert_equal 'http://test.com', ConfigurationStub.new.base_url
  end

  def test_default_screen
    assert_equal 'test', ConfigurationStub.new.default_screen
  end

  def test_screen_transition_sleep
    assert_equal 1, ConfigurationStub.new.screen_transition_sleep
  end

  def test_throttle_driver_methods
    assert_equal ({:find_element => 1}), ConfigurationStub.new.throttle_driver_methods
  end

  def test_throttle_element_methods
    assert_equal ({:click => 1}), ConfigurationStub.new.throttle_element_methods
  end
end
