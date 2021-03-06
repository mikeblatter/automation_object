# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/blue_print/composite/element_array'

# Test AutomationObject::BluePrint::Composite::ElementArray
class TestBluePrintCompositeElementArray < Minitest::Test
  def setup
    @mock = mock
    @subject = AutomationObject::BluePrint::Composite::ElementArray.new(@mock)
  end

  def test_selector_params
    @mock.expects(:selector_params).returns([:xpath, '//path/to/logo'])
    assert_equal [:xpath, '//path/to/logo'], @subject.selector_params
  end

  def test_in_iframe
    @mock.expects(:in_iframe).returns('iframe_element')
    assert_equal 'iframe_element', @subject.in_iframe
  end

  def test_in_iframe?
    @mock.expects(:in_iframe?).returns(true)
    assert_equal true, @subject.in_iframe?
  end

  def test_custom_range_hash
    @mock.expects(:custom_range).returns(start: 0, end: 5)
    assert_equal({ start: 0, end: 5 }, @subject.custom_range)
  end

  def test_custom_range_string
    @mock.expects(:custom_range).returns('0..5')
    assert_equal '0..5', @subject.custom_range
  end

  def test_remove_duplicates
    @mock.expects(:remove_duplicates).returns('test_element_value')
    assert_equal 'test_element_value', @subject.remove_duplicates
  end
end
