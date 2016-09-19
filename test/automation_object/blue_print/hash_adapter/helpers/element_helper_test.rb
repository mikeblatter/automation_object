# frozen_string_literal: true
require_relative '../../../../test_helper'
require_relative '../../../../../lib/automation_object/blue_print/hash_adapter/helpers/element_helper'

# Test AutomationObject::BluePrint::HashAdapter::ElementHelper
class TestElementHelper < Minitest::Test
  def setup
  end

  def extend_stub(stub_to_extend)
    stub_to_extend.extend(AutomationObject::BluePrint::HashAdapter::ElementHelper)
  end

  def test_selector_params_css
    composite_stub = stub(hash: { css: 'div# path .to .logo' })
    extended_stub = extend_stub(composite_stub)

    assert_equal [:css, 'div# path .to .logo'], extended_stub.selector_params
  end

  def test_selector_params_xpath
    composite_stub = stub(hash: { xpath: '//path/to/logo' })
    extended_stub = extend_stub(composite_stub)

    assert_equal [:xpath, '//path/to/logo'], extended_stub.selector_params
  end

  def test_selector_params_default
    composite_stub = stub(hash: {})
    extended_stub = extend_stub(composite_stub)

    assert_equal nil, extended_stub.selector_params
  end

  def test_in_iframe
    composite_stub = stub(hash: { in_iframe: 'iframe_element' })
    extended_stub = extend_stub(composite_stub)

    assert_equal :iframe_element, extended_stub.in_iframe
  end

  def test_in_iframe_default
    composite_stub = stub(hash: {})
    extended_stub = extend_stub(composite_stub)

    assert_equal nil, extended_stub.in_iframe
  end

  def test_in_iframe?
    composite_stub = stub(hash: { in_iframe: 'iframe_element' })
    extended_stub = extend_stub(composite_stub)

    assert_equal true, extended_stub.in_iframe?
  end

  def test_in_iframe_default?
    composite_stub = stub(hash: {})
    extended_stub = extend_stub(composite_stub)

    assert_equal false, extended_stub.in_iframe?
  end
end
