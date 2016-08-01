require_relative '_base'

#Test AutomationObject::BluePrint::HashAdapter::Element
class TestHashAdapterElement < Minitest::Test
  include HashAdapterBase

  self.interface_class = AutomationObject::BluePrint::Composite::Element
  self.adapter_class = AutomationObject::BluePrint::HashAdapter::Element
  self.defaults = {
      :load => AutomationObject::BluePrint::Composite::Hook.new({}),
      :custom_methods => {},
      :selector_params => nil,
      :in_iframe => nil,
      :in_iframe? => false
  }

  create_tests()

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