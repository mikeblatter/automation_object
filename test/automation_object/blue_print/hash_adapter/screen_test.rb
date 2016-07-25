require_relative '../../../test_helper'
require_relative 'test_helpers/test_default_helper'

require_relative '../../../../lib/automation_object/blue_print/hash_adapter/screen'

#Test AutomationObject::BluePrint::HashAdapter::Screen
class TestHashAdapterScreen < Minitest::Test
  include TestDefaultHelper

  def setup
    AutomationObject::BluePrint::HashAdapter::Screen.skip_validations = true
  end

  def teardown
    #Reset skip validations just in case.  Don't want to cause issues when we expect validation exceptions
    AutomationObject::BluePrint::HashAdapter::Screen.skip_validations = false
  end

  def create_composite(hash, parent = nil)
    return AutomationObject::BluePrint::HashAdapter::Screen.new(hash, :screen, parent)
  end

  def test_defaults
    AutomationObject::BluePrint::HashAdapter::Screen.skip_validations = true

    defaults = {
        :load => AutomationObject::BluePrint::HashAdapter::Hook,
        :accept => AutomationObject::BluePrint::HashAdapter::Hook,
        :dismiss => AutomationObject::BluePrint::HashAdapter::Hook,
        :modals => {},
        :elements => {},
        :element_arrays => {},
        :element_hashes => {},
        :automatic_onload_modals => [],
        :automatic_screen_changes => [],
        :included_views => [],
    }

    self.defaults_test(defaults, AutomationObject::BluePrint::HashAdapter::Screen)
  end

  def test_load
    composite = self.create_composite({ :load => {} })
    assert_instance_of AutomationObject::BluePrint::HashAdapter::Hook, composite.load
  end

  def test_accept
    composite = self.create_composite({ :accept => {} })
    assert_instance_of AutomationObject::BluePrint::HashAdapter::Hook, composite.accept
  end

  def test_dismiss
    composite = self.create_composite({ :dismiss => {} })
    assert_instance_of AutomationObject::BluePrint::HashAdapter::Hook, composite.dismiss
  end

  def test_modals
    composite = self.create_composite({ :modals => { :test_one => {}, :test_two => {}}})

    assert_instance_of Hash, composite.modals
    assert_equal 2, composite.modals.keys.length

    composite.modals.each { |composite_name, composite|
      assert_includes [:test_one, :test_two], composite_name
      assert_instance_of AutomationObject::BluePrint::HashAdapter::Modal, composite
    }
  end

  def test_elements
    composite = self.create_composite({ :elements => { :test_one => {}, :test_two => {}}})

    assert_instance_of Hash, composite.elements
    assert_equal 2, composite.elements.keys.length

    composite.elements.each { |composite_name, composite|
      assert_includes [:test_one, :test_two], composite_name
      assert_instance_of AutomationObject::BluePrint::HashAdapter::Element, composite
    }
  end

  def test_element_arrays
    composite = self.create_composite({ :element_arrays => { :test_one => {}, :test_two => {}}})

    assert_instance_of Hash, composite.element_arrays
    assert_equal 2, composite.element_arrays.keys.length

    composite.element_arrays.each { |composite_name, composite|
      assert_includes [:test_one, :test_two], composite_name
      assert_instance_of AutomationObject::BluePrint::HashAdapter::ElementArray, composite
    }
  end

  def test_element_hashes
    composite = self.create_composite({ :element_hashes => { :test_one => {}, :test_two => {}}})

    assert_instance_of Hash, composite.element_hashes
    assert_equal 2, composite.element_hashes.keys.length

    composite.element_hashes.each { |composite_name, composite|
      assert_includes [:test_one, :test_two], composite_name
      assert_instance_of AutomationObject::BluePrint::HashAdapter::ElementHash, composite
    }
  end

  def test_automatic_onload_modals
    composite = self.create_composite({ :automatic_onload_modals => [{}, {}]})

    assert_instance_of Array, composite.automatic_onload_modals
    assert_equal 2, composite.automatic_onload_modals.length

    composite.automatic_onload_modals.each { |composite|
      assert_instance_of AutomationObject::BluePrint::HashAdapter::AutomaticOnloadModal, composite
    }
  end

  def test_included_views
    composite = self.create_composite({ :included_views => [:test_view_one, 'test_view_two']})

    assert_instance_of Array, composite.included_views
    assert_equal 2, composite.included_views.length

    composite.included_views.each { |included_view|
      assert_includes [:test_view_one, :test_view_two], included_view
    }
  end

  def test_automatic_screen_changes
    composite = self.create_composite({ :automatic_screen_changes => [:test_screen_one, 'test_screen_two']})

    assert_instance_of Array, composite.automatic_screen_changes
    assert_equal 2, composite.automatic_screen_changes.length

    composite.automatic_screen_changes.each { |screen_name|
      assert_includes [:test_screen_one, :test_screen_two], screen_name
    }
  end

  def test_merge_views
    parent_stub = stub(
                      :hash => {
                           :views => {
                               :test_view => {
                                  :view_test_value => true
                               }
                           }
                      })

    composite = self.create_composite({ :included_views => [:test_view], :screen_test_value => true }, parent_stub)

    assert_includes composite.hash.keys, :screen_test_value
    assert_includes composite.hash.keys, :view_test_value

    assert_equal true, composite.hash[:screen_test_value]
    assert_equal true, composite.hash[:view_test_value]
  end
end