# frozen_string_literal: true
require_relative '_base'

# Test AutomationObject::BluePrint::HashAdapter::ElementHash
class TestHashAdapterElementHash < Minitest::Test
  include HashAdapterBase

  self.interface_class = AutomationObject::BluePrint::Composite::ElementHash
  self.adapter_class = AutomationObject::BluePrint::HashAdapter::ElementHash
  self.defaults = {
    load: AutomationObject::BluePrint::Composite::Hook,
    custom_methods: {},
    selector_params: nil,
    in_iframe: nil,
    in_iframe?: false,
    custom_range: nil,
    remove_duplicates: nil
  }

  create_tests

  def test_load
    composite = create_composite(load: {})
    assert_instance_of AutomationObject::BluePrint::Composite::Hook, composite.load
  end

  def test_selector_params_css
    composite_stub = create_composite(css: 'div# path .to .logo')
    assert_equal [:css, 'div# path .to .logo'], composite_stub.selector_params
  end

  def test_selector_params_xpath
    composite_stub = create_composite(xpath: '//path/to/logo')
    assert_equal [:xpath, '//path/to/logo'], composite_stub.selector_params
  end

  def test_in_iframe
    composite_stub = create_composite(in_iframe: 'iframe_element')
    assert_equal :iframe_element, composite_stub.in_iframe
  end

  def test_in_iframe?
    composite_stub = create_composite(in_iframe: 'iframe_element')
    assert_equal true, composite_stub.in_iframe?
  end

  def test_custom_range_hash
    composite_stub = create_composite(custom_range: { start: 0, end: 5 })
    assert_equal 0..5, composite_stub.custom_range
  end

  def test_custom_range_string
    composite_stub = create_composite(custom_range: '0..5')
    assert_equal 0..5, composite_stub.custom_range
  end

  def test_remove_duplicates
    composite_stub = create_composite(remove_duplicates: 'test_element_value')
    assert_equal :test_element_value, composite_stub.remove_duplicates
  end
end
