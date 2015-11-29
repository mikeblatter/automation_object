require_relative '../../../test_helper'
require_relative 'test_helpers/test_default_helper'

require_relative '../../../../lib/automation_object/blue_print/hash_adapter/hook_action'

#Test AutomationObject::BluePrint::HashAdapter::HookAction
class TestHashAdapterHookAction < Minitest::Test
  include TestDefaultHelper

  def setup
    AutomationObject::BluePrint::HashAdapter::HookAction.skip_validations = true
  end

  def teardown
    #Reset skip validations just in case.  Don't want to cause issues when we expect validation exceptions
    AutomationObject::BluePrint::HashAdapter::HookAction.skip_validations = false
  end

  def create_composite(hash)
    return AutomationObject::BluePrint::HashAdapter::HookAction.new(hash)
  end

  def test_defaults
    defaults = {
        :hook_order => [],
        :change_screen => nil,
        :change_to_previous_screen => false,
        :close_modal => false,
        :close_window => false,
        :possible_screen_changes => [],
        :reset_screen => false,
        :show_modal => nil,
        :sleep => 0,
        :wait_for_elements => [],
        :wait_for_new_window => false,
    }

    self.defaults_test(defaults, AutomationObject::BluePrint::HashAdapter::HookAction)
  end

  def test_hook_order
    composite = self.create_composite({ :change_screen => 'test_screen', :sleep => 1 })
    assert_equal [:change_screen, :sleep], composite.hook_order
  end

  def test_length
    composite = self.create_composite({ :change_screen => 'test_screen', :sleep => 1 })
    assert_equal 2, composite.length
  end

  def test_empty_true
    composite = self.create_composite({})
    assert_equal true, composite.empty?
  end

  def test_empty_false
    composite = self.create_composite({ :change_screen => 'test_screen', :sleep => 1 })
    assert_equal false, composite.empty?
  end

  def test_change_screen
    composite = self.create_composite({ :change_screen => 'test_screen' })
    assert_equal :test_screen, composite.change_screen
  end

  def test_close_window
    composite = self.create_composite({ :close_window => true })
    assert_equal true, composite.close_window
  end

  def test_change_to_previous_screen
    composite = self.create_composite({ :change_to_previous_screen => true })
    assert_equal true, composite.change_to_previous_screen
  end

  def test_close_modal
    composite = self.create_composite({ :close_modal => true })
    assert_equal true, composite.close_modal
  end

  def test_possible_screen_changes
    composite = self.create_composite({ :possible_screen_changes => [:test_screen_one, 'test_screen_two'] })
    assert_equal [:test_screen_one, :test_screen_two], composite.possible_screen_changes
  end

  def test_reset_screen
    composite = self.create_composite({ :close_modal => true })
    assert_equal true, composite.close_modal
  end

  def test_show_modal
    composite = self.create_composite({ :show_modal => 'test_modal' })
    assert_equal :test_modal, composite.show_modal
  end

  def test_sleep
    composite = self.create_composite({ :sleep => 1 })
    assert_equal 1, composite.sleep
  end

  def test_wait_for_elements
    composite = self.create_composite({ :wait_for_elements => [{}, {}] })
    assert_equal 2, composite.wait_for_elements.length

    composite.wait_for_elements.each { |hook_element_requirement|
      assert_instance_of AutomationObject::BluePrint::HashAdapter::HookElementRequirements, hook_element_requirement
    }
  end

  def test_wait_for_new_window
    composite = self.create_composite({ :wait_for_new_window => true })
    assert_equal true, composite.wait_for_new_window
  end
end