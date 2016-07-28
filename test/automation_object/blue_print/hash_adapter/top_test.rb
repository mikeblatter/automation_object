require_relative '../../../test_helper'
require_relative 'test_helpers/test_default_helper'

require_relative '../../../../lib/automation_object/blue_print/hash_adapter/top'

#Test AutomationObject::BluePrint::HashAdapter::Top < Composite
class TestHashAdapterTop < Minitest::Test
  include TestDefaultHelper

  def setup
    AutomationObject::BluePrint::HashAdapter::Top.skip_validations = true
  end

  def teardown
    #Reset skip validations just in case.  Don't want to cause issues when we expect validation exceptions
    AutomationObject::BluePrint::HashAdapter::Top.skip_validations = false
  end

  def create_composite(hash)
    return AutomationObject::BluePrint::HashAdapter::Top.new(hash)
  end

  def test_defaults
    defaults = {
        :base_url => nil,
        :default_screen => nil,
        :screen_transition_sleep => 0,
        :screens => {},
        :throttle_driver_methods => {},
        :throttle_element_methods => {}
    }

    self.defaults_test(defaults, AutomationObject::BluePrint::HashAdapter::Top)
  end

  def test_base_url
    composite = self.create_composite({ :base_url => 'test_url' })
    assert_equal 'test_url', composite.base_url
  end

  def test_default_screen_string
    composite = self.create_composite({ :default_screen => 'test_screen' })
    assert_equal :test_screen, composite.default_screen
  end

  def test_default_screen_symbol
    composite = self.create_composite({ :default_screen => :test_screen })
    assert_equal :test_screen, composite.default_screen
  end

  def test_screen_transition_sleep_integer
    composite = self.create_composite({ :screen_transition_sleep => 1 })
    assert_equal 1, composite.screen_transition_sleep
  end

  def test_screen_transition_sleep_float
    composite = self.create_composite({ :screen_transition_sleep => 0.5 })
    assert_equal 0.5, composite.screen_transition_sleep
  end

  def test_screens
    composite = self.create_composite({ :screens => { :test_screen_one => {}, :test_screen_two => {}}})

    assert_instance_of Hash, composite.screens
    composite.screens.each { |screen_name, screen_composite|
      assert_includes [:test_screen_one, :test_screen_two], screen_name
      assert_instance_of AutomationObject::BluePrint::Composite::Screen, screen_composite
    }
  end

  def test_throttle_driver_methods
    hash = { :test => 1 }

    composite = self.create_composite({ :throttle_driver_methods => hash })
    assert_equal hash, composite.throttle_driver_methods
  end

  def test_throttle_element_methods
    hash = { :test => 1 }

    composite = self.create_composite({ :throttle_element_methods => hash })
    assert_equal hash, composite.throttle_element_methods
  end
end