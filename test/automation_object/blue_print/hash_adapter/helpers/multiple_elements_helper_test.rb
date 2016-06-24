require_relative '../../../../test_helper'
require_relative '../../../../../lib/automation_object/blue_print/hash_adapter/helpers/multiple_elements_helper'

#Test AutomationObject::BluePrint::HashAdapter::MultipleElementsHelper
class TestMultipleElementsHelper < Minitest::Test
  def setup
  end

  def extend_stub(stub_to_extend)
    return stub_to_extend.extend(AutomationObject::BluePrint::HashAdapter::MultipleElementsHelper)
  end

  def test_custom_range_hash
    composite_stub = stub(:hash => { :custom_range => { :start => 0, :end => 5} })
    extended_stub = self.extend_stub(composite_stub)

    assert_equal 0..5, extended_stub.custom_range
  end

  def test_custom_range_string
    composite_stub = stub(:hash => { :custom_range => '0..5' })
    extended_stub = self.extend_stub(composite_stub)

    assert_equal 0..5, extended_stub.custom_range
  end

  def test_custom_range_default
    composite_stub = stub(:hash => {})
    extended_stub = self.extend_stub(composite_stub)

    assert_equal nil, extended_stub.custom_range
  end

  def test_remove_duplicates
    composite_stub = stub(:hash => { :remove_duplicates => 'test_element_value'} )
    extended_stub = self.extend_stub(composite_stub)

    assert_equal :test_element_value, extended_stub.remove_duplicates
  end

  def test_remove_duplicates_default
    composite_stub = stub(:hash => {})
    extended_stub = self.extend_stub(composite_stub)

    assert_equal nil, extended_stub.remove_duplicates
  end
end