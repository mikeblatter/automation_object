require_relative '_base'

#Test AutomationObject::BluePrint::HashAdapter::Hook
class TestHashAdapterHook < Minitest::Test
  include HashAdapterBase

  self.interface_class = AutomationObject::BluePrint::Composite::Hook
  self.adapter_class = AutomationObject::BluePrint::HashAdapter::Hook
  self.defaults = {
      :before => AutomationObject::BluePrint::Composite::HookAction,
      :live? => [],
      :after => AutomationObject::BluePrint::Composite::HookAction
  }

  create_tests()

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