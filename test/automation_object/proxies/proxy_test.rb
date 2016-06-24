require_relative '../../test_helper'
require_relative 'mocks/proxy_mock'

#Using custom mock classes, not thread-safe and hard to implement for proxies
#Test AutomationObject::Proxies::Proxy
class TestProxy < Minitest::Test
  def setup
    @proxy = AutomationObject::Proxies::Proxy.new(ProxyMock.new)
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