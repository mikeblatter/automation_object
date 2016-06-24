require_relative '../../../test_helper'
require_relative 'test_helpers/test_default_helper'

require_relative '../../../../lib/automation_object/blue_print/hash_adapter/view'

#Test AutomationObject::BluePrint::HashAdapter::View
class TestHashAdapterView < Minitest::Test
  include TestDefaultHelper

  def setup
    AutomationObject::BluePrint::HashAdapter::View.skip_validations = true
  end

  def teardown
    #Reset skip validations just in case.  Don't want to cause issues when we expect validation exceptions
    AutomationObject::BluePrint::HashAdapter::View.skip_validations = false
  end

  def create_composite(hash)
    return AutomationObject::BluePrint::HashAdapter::View.new(hash)
  end

  def test_defaults
    defaults = {
    }

    self.defaults_test(defaults, AutomationObject::BluePrint::HashAdapter::View)
  end
end