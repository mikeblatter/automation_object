# Mock for Proxy
class ProxyMock
  attr_accessor :test_attribute

  def initialize
    self.test_attribute = 'test'
  end

  def test_method
    true
  end
end
