# frozen_string_literal: true
require_relative '_base'

# Test AutomationObject::BluePrint::HashAdapter::Modal
class TestHashAdapterModal < Minitest::Test
  include HashAdapterBase

  self.interface_class = AutomationObject::BluePrint::Composite::Modal
  self.adapter_class = AutomationObject::BluePrint::HashAdapter::Modal
  self.defaults = {
    load: AutomationObject::BluePrint::Composite::Hook,
    elements: {},
    element_arrays: {},
    element_hashes: {}
  }

  create_tests

  def test_load
    composite = create_composite(load: {})
    assert_instance_of AutomationObject::BluePrint::Composite::Hook, composite.load
  end

  def test_elements
    composite = create_composite(elements: { test_one: {}, test_two: {} })

    assert_instance_of Hash, composite.elements
    assert_equal 2, composite.elements.keys.length

    composite.elements.each do |composite_name, sub_composite|
      assert_includes [:test_one, :test_two], composite_name
      assert_instance_of AutomationObject::BluePrint::Composite::Element, sub_composite
    end
  end

  def test_element_arrays
    composite = create_composite(element_arrays: { test_one: {}, test_two: {} })

    assert_instance_of Hash, composite.element_arrays
    assert_equal 2, composite.element_arrays.keys.length

    composite.element_arrays.each do |composite_name, sub_composite|
      assert_includes [:test_one, :test_two], composite_name
      assert_instance_of AutomationObject::BluePrint::Composite::ElementArray, sub_composite
    end
  end

  def test_element_hashes
    composite = create_composite(element_hashes: { test_one: {}, test_two: {} })

    assert_instance_of Hash, composite.element_hashes
    assert_equal 2, composite.element_hashes.keys.length

    composite.element_hashes.each do |composite_name, sub_composite|
      assert_includes [:test_one, :test_two], composite_name
      assert_instance_of AutomationObject::BluePrint::Composite::ElementHash, sub_composite
    end
  end
end
