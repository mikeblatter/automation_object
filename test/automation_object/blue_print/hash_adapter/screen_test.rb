# frozen_string_literal: true
require_relative '_base'

# Test AutomationObject::BluePrint::HashAdapter::Screen
class TestHashAdapterScreen < Minitest::Test
  include HashAdapterBase

  self.interface_class = AutomationObject::BluePrint::Composite::Screen
  self.adapter_class = AutomationObject::BluePrint::HashAdapter::Screen

  self.defaults = {
    load: AutomationObject::BluePrint::Composite::Hook,
    accept: AutomationObject::BluePrint::Composite::Hook,
    dismiss: AutomationObject::BluePrint::Composite::Hook,
    modals: {},
    elements: {},
    element_arrays: {},
    element_hashes: {},
    automatic_onload_modals: [],
    automatic_screen_changes: [],
    included_views: []
  }
  create_tests

  def test_load
    composite = create_composite(load: {})
    assert_instance_of AutomationObject::BluePrint::Composite::Hook, composite.load
  end

  def test_accept
    composite = create_composite(accept: {})
    assert_instance_of AutomationObject::BluePrint::Composite::Hook, composite.accept
  end

  def test_dismiss
    composite = create_composite(dismiss: {})
    assert_instance_of AutomationObject::BluePrint::Composite::Hook, composite.dismiss
  end

  def test_modals
    composite = create_composite(modals: { test_one: {}, test_two: {} })

    assert_instance_of Hash, composite.modals
    assert_equal 2, composite.modals.keys.length

    composite.modals.each do |composite_name, sub_composite|
      assert_includes [:test_one, :test_two], composite_name
      assert_instance_of AutomationObject::BluePrint::Composite::Modal, sub_composite
    end
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

  def test_automatic_onload_modals
    composite = create_composite(automatic_onload_modals: [{}, {}])

    assert_instance_of Array, composite.automatic_onload_modals
    assert_equal 2, composite.automatic_onload_modals.length

    composite.automatic_onload_modals.each do |sub_composite|
      assert_instance_of AutomationObject::BluePrint::Composite::AutomaticOnloadModal, sub_composite
    end
  end

  def test_included_views
    composite = create_composite(included_views: [:test_view_one, 'test_view_two'])

    assert_instance_of Array, composite.included_views
    assert_equal 2, composite.included_views.length

    composite.included_views.each do |included_view|
      assert_includes [:test_view_one, :test_view_two], included_view
    end
  end

  def test_automatic_screen_changes
    composite = create_composite(automatic_screen_changes: [:test_screen_one, 'test_screen_two'])

    assert_instance_of Array, composite.automatic_screen_changes
    assert_equal 2, composite.automatic_screen_changes.length

    composite.automatic_screen_changes.each do |screen_name|
      assert_includes [:test_screen_one, :test_screen_two], screen_name
    end
  end

  def test_merge_views
    AutomationObject::BluePrint::HashAdapter::Top.skip_validations = true
    parent = AutomationObject::BluePrint::HashAdapter::Top.new(views: {
                                                                 test_view: {
                                                                   view_test_value: true
                                                                 }
                                                               })

    composite = create_composite({ included_views: [:test_view], screen_test_value: true }, parent)

    assert_includes composite.hash.keys, :screen_test_value
    assert_includes composite.hash.keys, :view_test_value

    assert_equal true, composite.hash[:screen_test_value]
    assert_equal true, composite.hash[:view_test_value]

    AutomationObject::BluePrint::HashAdapter::Top.skip_validations = false
  end
end
