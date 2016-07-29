require_relative '../../../test_helper'
require_relative 'test_helpers/test_default_helper'

require_relative '../../../../lib/automation_object/blue_print/hash_adapter/hook_element_requirements'

#Test AutomationObject::BluePrint::HashAdapter::HookElementRequirements
class TestHashAdapterHookElementRequirements < Minitest::Test
  include TestDefaultHelper

  DEFAULTS = {
      :hook_order => [:exists?],
      :element_name => nil
  }

  def setup
    AutomationObject::BluePrint::HashAdapter::HookElementRequirements.skip_validations = true
  end

  def teardown
    #Reset skip validations just in case.  Don't want to cause issues when we expect validation exceptions
    AutomationObject::BluePrint::HashAdapter::HookElementRequirements.skip_validations = false
  end

  def create_composite(hash)
    return AutomationObject::BluePrint::HashAdapter::HookElementRequirements.new(hash)
  end

  def test_defaults
    self.defaults_test(DEFAULTS, AutomationObject::BluePrint::HashAdapter::HookElementRequirements)
  end

  def test_hook_order
    composite = self.create_composite({ :text => 'Text should be this', :exists? => true, :element_name => 'element_name'})
    assert_equal [:exists?, :text], composite.hook_order
  end

  def test_requirement
    composite = self.create_composite({ :text => 'Text should be this', :exists? => true, :element_name => 'element_name'})

    assert_equal 'Text should be this', composite.requirement(:text)
    assert_equal nil, composite.requirement(:nonexistent_key)
  end

  def test_element_name
    composite = self.create_composite({ :text => 'Text should be this', :exists? => true, :element_name => 'element_name'})
    assert_equal :element_name, composite.element_name
  end
end