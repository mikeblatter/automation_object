# frozen_string_literal: true
require_relative '_base'

# Test AutomationObject::BluePrint::HashAdapter::HookElementRequirements
class TestHashAdapterHookElementRequirements < Minitest::Test
  include HashAdapterBase

  self.interface_class = AutomationObject::BluePrint::Composite::HookElementRequirements
  self.adapter_class = AutomationObject::BluePrint::HashAdapter::HookElementRequirements
  self.defaults = {
    hook_order: [:exists?],
    element_name: nil
  }

  create_tests

  def test_hook_order
    composite = create_composite(text: 'Text should be this', exists?: true, element_name: 'element_name')
    assert_equal [:exists?, :text], composite.hook_order
  end

  def test_requirement
    composite = create_composite(text: 'Text should be this', exists?: true, element_name: 'element_name')

    assert_equal 'Text should be this', composite.requirement(:text)
    assert_nil composite.requirement(:nonexistent_key)
  end

  def test_element_name
    composite = create_composite(text: 'Text should be this', exists?: true, element_name: 'element_name')
    assert_equal :element_name, composite.element_name
  end
end
