require_relative '../../../test_helper'
require_relative 'test_helpers/test_default_helper'

require_relative '../../../../lib/automation_object/blue_print/hash_adapter/custom_method'

#Test AutomationObject::BluePrint::HashAdapter::CustomMethod
class TestHashAdapterCustomMethod < Minitest::Test
  include TestDefaultHelper

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

  def test_defaults
    defaults = {
        :element_method => nil,
        :evaluate => nil
    }

    self.defaults_test(defaults, AutomationObject::BluePrint::HashAdapter::CustomMethod)
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