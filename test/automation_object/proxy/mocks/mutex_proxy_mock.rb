# frozen_string_literal: true

# Mock for MutexProxy
class MutexProxyMock
  attr_accessor :test_attribute, :thread_working

  def initialize
    self.test_attribute = 'test'
    self.thread_working = false
  end

  def test_method
    true
  end

  def test_mutex
    return false if thread_working

    self.thread_working = true
    # Sleep is fine, tested without Mutex protection and it fails consistently
    sleep(0.001)
    self.thread_working = false

    true
  end
end
