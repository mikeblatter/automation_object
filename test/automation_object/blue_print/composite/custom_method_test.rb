# frozen_string_literal: true
require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/blue_print/composite/custom_method'

# Test AutomationObject::BluePrint::Composite::CustomMethod
class TestBluePrintCompositeCustomMethod < Minitest::Test
  def setup
    @mock = mock()
    @subject = AutomationObject::BluePrint::Composite::CustomMethod.new(@mock)
  end

  def test_element_method
    @mock.expects(:element_method).returns(:element_method)
    assert_equal :element_method, @subject.element_method
  end

  def test_evaluate
    @mock.expects(:evaluate).returns('test')
    assert_equal 'test', @subject.evaluate
  end
end
