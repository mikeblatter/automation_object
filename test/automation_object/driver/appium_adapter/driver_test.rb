# frozen_string_literal: true

require_relative '../adapter_test_helper'

# Test AutomationObject::Driver::AppiumAdapter::Driver class
class TestAppiumAdapterDriver < Minitest::Test
  include AdapterTestHelper

  self.interface_class = AutomationObject::Driver::Driver
  self.adapter_class = AutomationObject::Driver::AppiumAdapter::Driver

  create_tests

  def setup
    @driver_mock = mock('driver')
    @driver = AutomationObject::Driver::AppiumAdapter::Driver.new(@driver_mock)
  end

  def teardown
    @driver_mock = nil
    @driver = nil
  end

  def test_get
    @driver_mock.expects(:get).with('test')
    @driver.get('test')
  end

  def test_title
    @driver_mock.expects(:title).returns('test')
    assert_equal 'test', @driver.title
  end

  def test_wait
    @driver_mock.expects(:set_wait).with(1)
    @driver.wait(1)
  end

  def test_exists?; end

  def test_find_element; end

  def test_find_elements; end

  def test_accept_prompt
    @driver_mock.expects(:alert_accept)
    @driver.accept_prompt
  end

  def test_dismiss_prompt
    @driver_mock.expects(:alert_dismiss)
    @driver.dismiss_prompt
  end

  def test_browser?
    @driver_mock.expects(:available_contexts).returns(['WEBVIEW_12'])
    assert_equal true, @driver.browser?
  end

  def test_not_browser?
    @driver_mock.expects(:available_contexts).returns(['CDWindow-hdsd-3322323'])
    assert_equal false, @driver.browser?
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
    @driver_mock.expects(:driver_quit)
    @driver.quit
  end
end
