require_relative '../../../test_helper'
require_relative 'test_helpers/test_default_helper'

require_relative '../../../../lib/automation_object/blue_print/hash_adapter/custom_method'

#Test AutomationObject::BluePrint::HashAdapter::CustomMethod
class TestHashAdapterCustomMethod < Minitest::Test
  include TestDefaultHelper

  DEFAULTS = {
      :element_method => nil,
      :evaluate => nil
  }

  def setup
    AutomationObject::BluePrint::HashAdapter::CustomMethod.skip_validations = true
  end

  def teardown
    #Reset skip validations just in case.  Don't want to cause issues when we expect validation exceptions
    AutomationObject::BluePrint::HashAdapter::CustomMethod.skip_validations = false
  end

  def create_composite(hash)
    return AutomationObject::BluePrint::HashAdapter::CustomMethod.new(hash)
  end

  #Test that class conforms to the composite interface
  AutomationObject::BluePrint::Composite::CustomMethod.public_instance_methods(false).each do |method|
    define_method("test_interface_#{method}") do
      assert create_composite(hash).public_methods.include?(method),
             "AutomationObject::BluePrint::HashAdapter::CustomMethod should have instance method: #{method}"
    end
  end

  def test_defaults
    self.defaults_test(DEFAULTS, AutomationObject::BluePrint::HashAdapter::CustomMethod)
  end

  def test_element_method
    composite = self.create_composite({:element_method => 'element_method'})
    assert_equal :element_method, composite.element_method
  end

  def test_evaluate
    composite = self.create_composite({:evaluate => 'test'})
    assert_equal 'test', composite.evaluate
  end
end