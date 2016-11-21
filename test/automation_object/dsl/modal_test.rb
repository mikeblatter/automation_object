# frozen_string_literal: true
require_relative '../../test_helper'

BLUE_PRINT_HASH = { :screens => {:test_screen => { :modals => { :test_modal => {}}}}}

# Test AutomationObject::Dsl::Modal
class TestDslModal < Minitest::Test
  def setup
    @blue_prints = AutomationObject::BluePrint.create(BLUE_PRINT_HASH)
    @state = AutomationObject::State::Top.new(nil, @blue_prints)
  end

  def test_active?
    #modal = AutomationObject::Dsl::ModalProxy.new(@blue_prints.screens[:test_screen].modals[:test_modal], @state.screens[:test_screen], :test_screen)
    #assert_equal false, modal.active?

    #@state.screens[:test_screen].modals[:test_modal].active = true
    #assert_equal true, modal.active?
  end

  def test_screens
    #modal = AutomationObject::Dsl::ModalProxy.new(@blue_prints.screens[:test_screen], @state.screens[:test_screen], :test_screen)
    #refute_nil modal.test_screen
  end

  def teardown
  end
end