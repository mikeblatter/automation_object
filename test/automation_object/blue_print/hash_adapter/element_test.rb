require_relative '../../../test_helper'
require_relative 'test_helpers/test_default_helper'

require_relative '../../../../lib/automation_object/blue_print/hash_adapter/element'

#Test AutomationObject::BluePrint::HashAdapter::Element
class TestHashAdapterElement < Minitest::Test
  include TestDefaultHelper

  DEFAULTS = {
      :load => AutomationObject::BluePrint::Composite::Hook.new({}),
      :custom_methods => {},
      :selector_params => nil,
      :in_iframe => nil,
      :in_iframe? => false
  }

  def setup
    AutomationObject::BluePrint::HashAdapter::Element.skip_validations = true
  end

  def teardown
    #Reset skip validations just in case.  Don't want to cause issues when we expect validation exceptions
    AutomationObject::BluePrint::HashAdapter::Element.skip_validations = false
  end

  def create_composite(hash)
    return AutomationObject::BluePrint::HashAdapter::Element.new(hash)
  end

  #Test that class conforms to the composite interface
  AutomationObject::BluePrint::Composite::ElementHash.public_instance_methods(false).each do |method|
    define_method("test_interface_#{method}") do
      assert create_composite(hash).public_methods.include?(method),
             "AutomationObject::BluePrint::HashAdapter::ElementHash should have instance method: #{method}"
    end
  end

  def test_defaults
    AutomationObject::BluePrint::HashAdapter::Element.skip_validations = true
    self.defaults_test(DEFAULTS, AutomationObject::BluePrint::HashAdapter::Element)
  end

  def test_load
    composite = self.create_composite({ :load => {} })
    assert_instance_of AutomationObject::BluePrint::Composite::Hook, composite.load
  end

  def test_selector_params_css
    composite_stub = self.create_composite({ :css => 'div#path .to .logo' })
    assert_equal [:css, 'div#path .to .logo'], composite_stub.selector_params
  end

  def test_selector_params_xpath
    composite_stub = self.create_composite({ :xpath => '//path/to/logo' })
    assert_equal [:xpath, '//path/to/logo'], composite_stub.selector_params
  end

  def test_in_iframe
    composite_stub = self.create_composite({ :in_iframe => 'iframe_element' })
    assert_equal :iframe_element, composite_stub.in_iframe
  end

  def test_in_iframe?
    composite_stub = self.create_composite({ :in_iframe => 'iframe_element' })
    assert_equal true, composite_stub.in_iframe?
  end
end