# frozen_string_literal: true
require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/blue_print/composite/hook_action'

# Test AutomationObject::BluePrint::Composite::HookAction
class TestBluePrintCompositeHookAction < Minitest::Test
  def setup
    @mock = mock()
    @subject = AutomationObject::BluePrint::Composite::HookAction.new(@mock)
  end

  def test_hook_order
    @mock.expects(:hook_order).returns([:change_screen, :sleep])
    assert_equal [:change_screen, :sleep], @subject.hook_order
  end

  def test_length
    @mock.expects(:length).returns(2)
    assert_equal 2, @subject.length
  end

  def test_empty
    @mock.expects(:empty?).returns(true)
    assert_equal true, @subject.empty?
  end

  def test_change_screen
    @mock.expects(:change_screen).returns(:test_screen)
    assert_equal :test_screen, @subject.change_screen
  end

  def test_close_screen
    @mock.expects(:close_screen).returns(true)
    assert_equal true, @subject.close_screen
  end

  def test_change_to_previous_screen
    @mock.expects(:change_to_previous_screen).returns(true)
    assert_equal true, @subject.change_to_previous_screen
  end

  def test_close_modal
    @mock.expects(:close_modal).returns(true)
    assert_equal true, @subject.close_modal
  end

  def test_possible_screen_changes
    @mock.expects(:possible_screen_changes).returns([:test_screen_one, :test_screen_two])
    assert_equal [:test_screen_one, :test_screen_two], @subject.possible_screen_changes
  end

  def test_reset_screen
    @mock.expects(:close_modal).returns(true)
    assert_equal true, @subject.close_modal
  end

  def test_show_modal
    @mock.expects(:show_modal).returns(:test_modal)
    assert_equal :test_modal, @subject.show_modal
  end

  def test_sleep
    @mock.expects(:sleep).returns(1)
    assert_equal 1, @subject.sleep
  end

  def test_wait_for_elements
    @mock.expects(:wait_for_elements).returns([])
    assert_equal [], @subject.wait_for_elements
  end

  def test_new_screen
    @mock.expects(:new_screen).returns(:new_screen)
    assert_equal :new_screen, @subject.new_screen
  end
end
