# frozen_string_literal: true

require_relative '../../test_helper'
require_relative 'mocks/proxy_mock'

# Using custom mock classes, not thread-safe and hard to implement for proxy
# Test AutomationObject::Proxy::Proxy
class TestProxy < Minitest::Test
  def setup
    @proxy = AutomationObject::Proxy::Proxy.new(ProxyMock.new)
  end

  def test_class
    assert_equal ProxyMock, @proxy.class
  end

  def test_attribute
    assert_respond_to @proxy, :test_attribute
    assert_equal @proxy.test_attribute, 'test'
  end

  def test_method
    assert_respond_to @proxy, :test_method
    assert_equal @proxy.test_method, true
  end
end
