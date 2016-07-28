require_relative '../../../test_helper'
require_relative 'test_helpers/test_default_helper'

require_relative '../../../../lib/automation_object/blue_print/hash_adapter/modal'

#Test AutomationObject::BluePrint::HashAdapter::Modal
class TestHashAdapterModal < Minitest::Test
  include TestDefaultHelper

  def setup
    AutomationObject::BluePrint::HashAdapter::Modal.skip_validations = true
  end

  def teardown
    #Reset skip validations just in case.  Don't want to cause issues when we expect validation exceptions
    AutomationObject::BluePrint::HashAdapter::Modal.skip_validations = false
  end

  def create_composite(hash)
    return AutomationObject::BluePrint::HashAdapter::Modal.new(hash)
  end

  def test_defaults
    AutomationObject::BluePrint::HashAdapter::Modal.skip_validations = true

    defaults = {
        :load => AutomationObject::BluePrint::Composite::Hook,
        :elements => {},
        :element_arrays => {},
        :element_hashes => {}
    }

    self.defaults_test(defaults, AutomationObject::BluePrint::HashAdapter::Modal)
  end

  def test_load
    composite = self.create_composite({ :load => {} })
    assert_instance_of AutomationObject::BluePrint::Composite::Hook, composite.load
  end

  def test_elements
    composite = self.create_composite({ :elements => { :test_one => {}, :test_two => {}}})

    assert_instance_of Hash, composite.elements
    assert_equal 2, composite.elements.keys.length

    composite.elements.each { |composite_name, composite|
      assert_includes [:test_one, :test_two], composite_name
      assert_instance_of AutomationObject::BluePrint::Composite::Element, composite
    }
  end

  def test_element_arrays
    composite = self.create_composite({ :element_arrays => { :test_one => {}, :test_two => {}}})

    assert_instance_of Hash, composite.element_arrays
    assert_equal 2, composite.element_arrays.keys.length

    composite.element_arrays.each { |composite_name, composite|
      assert_includes [:test_one, :test_two], composite_name
      assert_instance_of AutomationObject::BluePrint::Composite::ElementArray, composite
    }
  end

  def test_element_hashes
    composite = self.create_composite({ :element_hashes => { :test_one => {}, :test_two => {}}})

    assert_instance_of Hash, composite.element_hashes
    assert_equal 2, composite.element_hashes.keys.length

    composite.element_hashes.each { |composite_name, composite|
      assert_includes [:test_one, :test_two], composite_name
      assert_instance_of AutomationObject::BluePrint::Composite::ElementHash, composite
    }
  end
end