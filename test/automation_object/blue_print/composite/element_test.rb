# frozen_string_literal: true
require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/blue_print/composite/element'

# Test AutomationObject::BluePrint::Composite::Element
class TestBluePrintCompositeElement < Minitest::Test
  def setup
    @mock = mock
    @subject = AutomationObject::BluePrint::Composite::Element.new(@mock)
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
end
