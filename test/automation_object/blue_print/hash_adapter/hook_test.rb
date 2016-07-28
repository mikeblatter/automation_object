require_relative '../../../test_helper'
require_relative 'test_helpers/test_default_helper'

require_relative '../../../../lib/automation_object/blue_print/hash_adapter/hook'

#Test AutomationObject::BluePrint::HashAdapter::Hook
class TestHashAdapterHook < Minitest::Test
  include TestDefaultHelper

  def setup
    AutomationObject::BluePrint::HashAdapter::Hook.skip_validations = true
  end

  def teardown
    #Reset skip validations just in case.  Don't want to cause issues when we expect validation exceptions
    AutomationObject::BluePrint::HashAdapter::Hook.skip_validations = false
  end

  def create_composite(hash)
    return AutomationObject::BluePrint::HashAdapter::Hook.new(hash)
  end

  def test_defaults
    AutomationObject::BluePrint::HashAdapter::Hook.skip_validations = true

    defaults = {
        :before => AutomationObject::BluePrint::Composite::HookAction,
        :live? => [],
        :after => AutomationObject::BluePrint::Composite::HookAction
    }

    self.defaults_test(defaults, AutomationObject::BluePrint::HashAdapter::Hook)
  end

  def test_before
    composite = self.create_composite({ :before => {} })
    assert_instance_of AutomationObject::BluePrint::Composite::HookAction, composite.before
  end

  def test_after
    composite = self.create_composite({ :after => {} })
    assert_instance_of AutomationObject::BluePrint::Composite::HookAction, composite.after
  end

  def test_live?
    composite = self.create_composite({ :live? => [{}, {}] })
    assert_equal 2, composite.live?.length

    composite.live?.each { |hook_element_requirement|
      assert_instance_of AutomationObject::BluePrint::Composite::HookElementRequirements, hook_element_requirement
    }
  end
end