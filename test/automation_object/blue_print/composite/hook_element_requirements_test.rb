# frozen_string_literal: true
require_relative '../../../test_helper'
require_relative '../../../../lib/automation_object/blue_print/composite/hook_element_requirements'

# Test AutomationObject::BluePrint::Composite::HookElementRequirements
class TestBluePrintCompositeHookElementRequirements < Minitest::Test
  def setup
    @mock = mock
    @subject = AutomationObject::BluePrint::Composite::HookElementRequirements.new(@mock)
  end

  def test_hook_order
    @mock.expects(:hook_order).returns([:exists?, :text])
    assert_equal [:exists?, :text], @subject.hook_order
  end

  def test_requirement
    @mock.expects(:requirement).with(:text).returns('Text should be this')
    assert_equal 'Text should be this', @subject.requirement(:text)
  end

  def test_element_name
    @mock.expects(:element_name).returns(:element_name)
    assert_equal :element_name, @subject.element_name
  end

  def test_element_blueprints
    @mock.expects(:element_blueprints).with(:test).returns(:blue_prints)
    assert_equal :blue_prints, @subject.element_blueprints(:test)
  end
end
