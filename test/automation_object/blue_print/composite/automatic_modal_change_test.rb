# frozen_string_literal: true
require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/blue_print/composite/automatic_modal_change'

# Test AutomationObject::BluePrint::Composite::AutomaticModalChange
class TestBluePrintCompositeAutomaticModalChange < Minitest::Test
  def setup
    @mock = mock
    @subject = AutomationObject::BluePrint::Composite::AutomaticModalChange.new(@mock)
  end

  def test_modal_name
    @mock.expects(:modal_name).returns(:test_modal)
    assert_equal :test_modal, @subject.modal_name
  end

  def test_number_of_checks
    @mock.expects(:number_of_checks).returns(2)
    assert_equal 2, @subject.number_of_checks
  end

  def test_close
    @mock.expects(:close).returns(true)
    assert_equal true, @mock.close
  end
end
