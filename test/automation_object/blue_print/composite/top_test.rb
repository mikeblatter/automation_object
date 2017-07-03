# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/blue_print/composite/top'

# Test AutomationObject::BluePrint::Composite::Top
class TestBluePrintCompositeTop < Minitest::Test
  def setup
    @mock = mock
    @subject = AutomationObject::BluePrint::Composite::Top.new(@mock)
  end

  def test_base_url
    @mock.expects(:base_url).returns('test_url')
    assert_equal 'test_url', @subject.base_url
  end

  def test_default_screen
    @mock.expects(:default_screen).returns(:test_screen)
    assert_equal :test_screen, @subject.default_screen
  end

  def test_screen_transition_sleep
    @mock.expects(:screen_transition_sleep).returns(1)
    assert_equal 1, @subject.screen_transition_sleep
  end

  def test_screens
    @mock.expects(:screens).returns({})
    assert_equal({}, @subject.screens)
  end

  def test_throttle_driver_methods
    @mock.expects(:throttle_driver_methods).returns({})
    assert_equal({}, @subject.throttle_driver_methods)
  end

  def test_throttle_element_methods
    @mock.expects(:throttle_element_methods).returns({})
    assert_equal({}, @subject.throttle_element_methods)
  end
end
