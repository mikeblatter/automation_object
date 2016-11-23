# frozen_string_literal: true
require_relative '../../test_helper'

# Test AutomationObject::Dsl::Top
class TestDslTop < Minitest::Test
  def setup
    screen_blue_prints = stub(:elements => {}, :element_arrays => {}, :element_hashes => {}, :modals => {})
    @blue_prints = stub(:screens => { :home_screen => screen_blue_prints })
    @state = stub(:screens => {})
  end

  def teardown
  end

  def test_active?
    dsl = AutomationObject::Dsl::TopProxy.new(@blue_prints, @state, :test)
    assert_equal true, dsl.active?
  end

  def test_screens
    dsl = AutomationObject::Dsl::TopProxy.new(@blue_prints, @state, :test)
    refute_nil dsl.home_screen
  end
end