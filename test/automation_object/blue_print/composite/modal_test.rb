# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/blue_print/composite/modal'

# Test AutomationObject::BluePrint::Composite::Modal
class TestBluePrintCompositeModal < Minitest::Test
  def setup
    @mock = mock
    @subject = AutomationObject::BluePrint::Composite::Modal.new(@mock)
  end

  def test_load
    @mock.expects(:load).returns({})
    assert_equal({}, @subject.load)
  end

  def test_included_views
    @mock.expects(:included_views).returns([:test_view])
    assert_equal([:test_view], @subject.included_views)
  end

  def test_elements
    @mock.expects(:elements).returns({})
    assert_equal({}, @subject.elements)
  end

  def test_element_arrays
    @mock.expects(:element_arrays).returns({})
    assert_equal({}, @subject.element_arrays)
  end

  def test_element_hashes
    @mock.expects(:element_hashes).returns({})
    assert_equal({}, @subject.element_hashes)
  end
end
