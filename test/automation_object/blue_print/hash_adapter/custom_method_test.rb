require_relative '_base'

# Test AutomationObject::BluePrint::HashAdapter::CustomMethod
class TestHashAdapterCustomMethod < Minitest::Test
  include HashAdapterBase

  self.interface_class = AutomationObject::BluePrint::Composite::CustomMethod
  self.adapter_class = AutomationObject::BluePrint::HashAdapter::CustomMethod
  self.defaults = {
    element_method: nil,
    evaluate: nil
  }

  create_tests

  def test_element_method
    composite = create_composite(element_method: 'element_method')
    assert_equal :element_method, composite.element_method
  end

  def test_evaluate
    composite = create_composite(evaluate: 'test')
    assert_equal 'test', composite.evaluate
  end
end
