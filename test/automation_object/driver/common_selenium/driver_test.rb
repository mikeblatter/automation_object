# frozen_string_literal: true
require_relative '../../../test_helper'

class DriverModuleContainer
  def initialize(driver)
    @subject = driver
  end

  include AutomationObject::Driver::CommonSelenium::Driver
end


# Test AutomationObject::Driver::CommonSelenium::Driver
class TestDriverCommonSeleniumDriver < Minitest::Test
  def setup
    #@driver_mock = mock('driver')
    #@driver = DriverModuleContainer.new(@driver_mock)
  end

  def teardown
    #@driver = nil
    #@driver_mock = nil
  end

  def test_scroll_position
  end

  def test_inner_window_height
    #@driver_mock.expects(:execute_script).with('return window.innerHeight;').returns(41)
    #assert_equal 41.0, @driver.inner_window_height
  end

  def test_execute_script
    #@driver_mock.expects(:execute_script).with('return window.innerHeight;').returns(41)
    #assert_equal 41.0, @driver.execute_script('return window.innerHeight;')
  end

  def test_back
  end

  def test_forward
  end

  def test_refresh
  end
end
