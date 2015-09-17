require_relative '../../../test_helper'
require_relative 'test_helpers/test_default_helper'

require_relative '../../../../lib/automation_object/blue_print/hash_adapter/automatic_onload_modal'

#Test AutomationObject::BluePrint::HashAdapter::AutomaticOnloadModal
class TestHashAdapterAutomaticOnloadModal < Minitest::Test
  include TestDefaultHelper

  def setup
    AutomationObject::BluePrint::HashAdapter::AutomaticOnloadModal.skip_validations = true
  end

  def teardown
    #Reset skip validations just in case.  Don't want to cause issues when we expect validation exceptions
    AutomationObject::BluePrint::HashAdapter::AutomaticOnloadModal.skip_validations = false
  end

  def create_composite(hash)
    return AutomationObject::BluePrint::HashAdapter::AutomaticOnloadModal.new(hash)
  end

  def test_defaults
    defaults = {
        :modal_name => nil,
        :number_of_checks => 1,
        :close => false
    }

    self.defaults_test(defaults, AutomationObject::BluePrint::HashAdapter::AutomaticOnloadModal)
  end

  def test_modal_name
    composite = self.create_composite({:modal_name => 'test_modal'})
    assert_equal :test_modal, composite.modal_name
  end

  def test_number_of_checks
    composite = self.create_composite({:number_of_checks => 2})
    assert_equal 2, composite.number_of_checks
  end

  def test_close
    composite = self.create_composite({:close => true})
    assert_equal true, composite.close
  end
end