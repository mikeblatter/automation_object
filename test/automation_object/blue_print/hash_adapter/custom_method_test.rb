require_relative '_base'

#Test AutomationObject::BluePrint::HashAdapter::CustomMethod
class TestHashAdapterCustomMethod < Minitest::Test
  INTERFACE_CLASS = AutomationObject::BluePrint::Composite::CustomMethod
  ADAPTER_CLASS = AutomationObject::BluePrint::HashAdapter::CustomMethod

  DEFAULTS = {
      :element_method => nil,
      :evaluate => nil
  }

  include HashAdapterBase

  def test_element_method
    composite = self.create_composite({:element_method => 'element_method'})
    assert_equal :element_method, composite.element_method
  end

  def test_evaluate
    composite = self.create_composite({:evaluate => 'test'})
    assert_equal 'test', composite.evaluate
  end
end