require_relative '../../test_helper'
require_relative 'mocks/mutex_proxy_mock'

# Using custom mock classes, not thread-safe and hard to implement for proxy
# Test AutomationObject::Proxy::MutexProxy
class TestMutexProxy < Minitest::Test
  def setup
    @proxy = AutomationObject::Proxy::MutexProxy.new(MutexProxyMock.new)
  end

  def test_class
    assert_equal MutexProxyMock, @proxy.class
  end

  def test_attribute
    assert_respond_to @proxy, :test_attribute
    assert_equal @proxy.test_attribute, 'test'
  end

  def test_method
    assert_respond_to @proxy, :test_method
    assert_equal @proxy.test_method, true
  end

  def test_mutex
    threads = Array.new

    5.times do
      threads.push(Thread.new {
        assert_equal @proxy.test_mutex, true
      })
    end

    threads.each { |thread|
      thread.join
    }
  end
end
