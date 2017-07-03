# frozen_string_literal: true

require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/blue_print/composite/hook'

# Test AutomationObject::BluePrint::Composite::Hook
class TestBluePrintCompositeHook < Minitest::Test
  def setup
    @mock = mock
    @subject = AutomationObject::BluePrint::Composite::Hook.new(@mock)
  end

  def test_before
    @mock.expects(:before).returns({})
    assert_equal({}, @subject.before)
  end

  def test_after
    @mock.expects(:after).returns({})
    assert_equal({}, @subject.after)
  end

  def test_live?
    @mock.expects(:live?).returns({})
    assert_equal({}, @subject.live?)
  end
end
