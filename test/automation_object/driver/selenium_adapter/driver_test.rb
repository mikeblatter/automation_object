# frozen_string_literal: true

require_relative '../adapter_test_helper'

# Test AutomationObject::Driver::NokogiriAdapter::Driver class
class TestSeleniumAdapterDriver < Minitest::Test
  include AdapterTestHelper

  self.interface_class = AutomationObject::Driver::Driver
  self.adapter_class = AutomationObject::Driver::SeleniumAdapter::Driver

  create_tests

  def setup
    @driver_mock = mock('driver')
    @driver = AutomationObject::Driver::SeleniumAdapter::Driver.new(@driver_mock)
  end

  def teardown
    @driver_mock = nil
    @driver = nil
  end

  def test_get; end

  def test_title
    @driver_mock.expects(:title).returns('test')
    assert_equal 'test', @driver.title
  end

  def test_wait; end

  def test_exists?; end

  def test_find_element; end

  def test_find_elements; end

  def test_accept_prompt; end

  def test_dismiss_prompt; end

  def test_browser?
    assert_equal true, @driver.browser?
  end

  def test_window_handles; end

  def test_window_handle; end

  def test_window_handle_set; end

  def test_document_complete?; end

  def test_close
    @driver_mock.expects(:close)
    @driver.close
  end

  def test_quit
    @driver_mock.expects(:quit)
    @driver.quit
  end
end
