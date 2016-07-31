require_relative '_base'

#Test AutomationObject::BluePrint::HashAdapter::Hook
class TestHashAdapterHook < Minitest::Test
  INTERFACE_CLASS = AutomationObject::BluePrint::Composite::Hook
  ADAPTER_CLASS = AutomationObject::BluePrint::HashAdapter::Hook

  DEFAULTS = {
      :before => AutomationObject::BluePrint::Composite::HookAction,
      :live? => [],
      :after => AutomationObject::BluePrint::Composite::HookAction
  }

  include HashAdapterBase

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