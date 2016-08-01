require_relative '_base'

#Test AutomationObject::BluePrint::HashAdapter::HookAction
class TestHashAdapterHookAction < Minitest::Test
  include HashAdapterBase

  self.interface_class = AutomationObject::BluePrint::Composite::HookAction
  self.adapter_class = AutomationObject::BluePrint::HashAdapter::HookAction
  self.defaults = {
      :hook_order => [],
      :change_screen => nil,
      :change_to_previous_screen => false,
      :close_modal => false,
      :close_screen => false,
      :possible_screen_changes => [],
      :reset_screen => false,
      :show_modal => nil,
      :sleep => 0,
      :wait_for_elements => [],
      :new_screen => nil,
  }

  create_tests()

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

  def test_close_screen
    composite = self.create_composite({ :close_screen => true })
    assert_equal true, composite.close_screen
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
      assert_instance_of AutomationObject::BluePrint::Composite::HookElementRequirements, hook_element_requirement
    }
  end

  def test_new_screen
    composite = self.create_composite({ :new_screen => 'new_screen' })
    assert_equal :new_screen, composite.new_screen
  end
end