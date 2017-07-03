# frozen_string_literal: true

require_relative '../../test_helper'
require_relative 'mocks/throttle_proxy_mock'

# Using custom mock classes, not thread-safe and hard to implement for proxy
# Test AutomationObject::Proxy::ThrottleProxy
class TestThrottleProxy < Minitest::Test
  def setup
    @throttle_proxy = AutomationObject::Proxy::ThrottleProxy.new(ThrottleProxyMock.new)
  end

  def test_class
    assert_equal ThrottleProxyMock, @throttle_proxy.class
  end

  def test_attribute
    assert_respond_to @throttle_proxy, :test_attribute
    assert_equal @throttle_proxy.test_attribute, 'test'
  end

  def test_method
    assert_respond_to @throttle_proxy, :test_method
    assert_equal @throttle_proxy.test_method, true
  end

  def test_add_method_throttle
    @throttle_proxy.add_method_throttle(:test_method, 1)
    assert_equal @throttle_proxy.throttle_methods[:test_method], 1

    start_time = Time.now.to_f
    @throttle_proxy.test_method # Should take longer 1 second
    total_time = Time.now.to_f - start_time
    assert_operator total_time, :>, 1
  end

  def test_delete_method_throttle
    @throttle_proxy.add_method_throttle(:test_method, 1)
    @throttle_proxy.delete_method_throttle(:test_method)
    assert_nil @throttle_proxy.throttle_methods[:test_method]
  end
end
