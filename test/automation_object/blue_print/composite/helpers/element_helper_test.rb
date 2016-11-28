# frozen_string_literal: true
require_relative '../../../../test_helper'

class ElementHelperContainer
  include AutomationObject::BluePrint::Composite::ElementHelper

  attr_accessor :adapter

  def initialize(adapter)
    self.adapter = adapter
  end
end

# Test AutomationObject::BluePrint::Composite::CustomMethod
class TestBluePrintCompositeElementHelper < Minitest::Test
  def setup
    @mock = mock()
    @subject = ElementHelperContainer.new(@mock)
  end

  def teardown
    @mock = nil
    @subject = nil
  end

  def test_selector_params
    @mock.expects(:selector_params).returns([:xpath, 'blah'])
    assert_equal [:xpath, 'blah'], @subject.selector_params
  end

  def test_in_iframe
    @mock.expects(:in_iframe).returns(:element)
    assert_equal :element, @subject.in_iframe
  end

  def test_in_iframe?
    @mock.expects(:in_iframe?).returns(true)
    assert_equal true, @subject.in_iframe?
  end

  def test_method_hook?
    @mock.expects(:method_hook?).with(:element).returns(true)
    assert_equal true, @subject.method_hook?(:element)
  end

  def test_method_hooks
    @mock.expects(:method_hooks).returns([])
    assert_equal [], @subject.method_hooks
  end
end
