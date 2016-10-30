# frozen_string_literal: true
require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/blue_print/composite/view'

# Test AutomationObject::BluePrint::Composite::View
class TestBluePrintCompositeView < Minitest::Test
  def setup
    @mock = mock
    @subject = AutomationObject::BluePrint::Composite::View.new(@mock)
  end

  def test_load
    @mock.expects(:load).returns({})
    assert_equal({}, @subject.load)
  end

  def test_accept
    @mock.expects(:accept).returns({})
    assert_equal({}, @subject.accept)
  end

  def test_dismiss
    @mock.expects(:dismiss).returns({})
    assert_equal({}, @subject.dismiss)
  end

  def test_modals
    @mock.expects(:modals).returns({})
    assert_equal({}, @subject.modals)
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

  def test_automatic_onload_modals
    @mock.expects(:element_hashes).returns({})
    assert_equal({}, @subject.element_hashes)
  end

  def test_automatic_screen_changes
    @mock.expects(:automatic_screen_changes).returns({})
    assert_equal({}, @subject.automatic_screen_changes)
  end
end
