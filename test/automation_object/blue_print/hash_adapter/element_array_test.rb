require_relative '_base'

#Test AutomationObject::BluePrint::HashAdapter::ElementArray
class TestHashAdapterElementArray < Minitest::Test
  INTERFACE_CLASS = AutomationObject::BluePrint::Composite::ElementArray
  ADAPTER_CLASS = AutomationObject::BluePrint::HashAdapter::ElementArray

  DEFAULTS = {
      :load => AutomationObject::BluePrint::Composite::Hook,
      :custom_methods => {},
      :selector_params => nil,
      :in_iframe => nil,
      :in_iframe? => false,
      :custom_range => nil,
      :remove_duplicates => nil
  }

  include HashAdapterBase

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

  def test_custom_range_hash
    composite_stub = self.create_composite({ :custom_range => { :start => 0, :end => 5} })
    assert_equal 0..5, composite_stub.custom_range
  end

  def test_custom_range_string
    composite_stub = self.create_composite({ :custom_range => '0..5' })
    assert_equal 0..5, composite_stub.custom_range
  end

  def test_remove_duplicates
    composite_stub = self.create_composite({ :remove_duplicates => 'test_element_value'} )
    assert_equal :test_element_value, composite_stub.remove_duplicates
  end
end