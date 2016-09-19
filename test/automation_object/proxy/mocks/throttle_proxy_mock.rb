# frozen_string_literal: true
# Mock for ThrottleProxy
class ThrottleProxyMock
  attr_accessor :test_attribute

  def initialize
    self.test_attribute = 'test'
  end

  def test_method
    true
  end
end
