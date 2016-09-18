require_relative '../../../../../test_helper'
require_relative '../../../../../../lib/automation_object/blue_print/hash_adapter/helpers/validators/validate'

# Test AutomationObject::BluePrint::HashAdapter::Validators::Validate
class TestValidate < Minitest::Test
  def setup
  end

  def test_error_messages_default
    validator = AutomationObject::BluePrint::HashAdapter::Validators::Validate.new

    assert_instance_of Array, validator.error_messages
  end

  def test_valid?
    validator = AutomationObject::BluePrint::HashAdapter::Validators::Validate.new
    assert_equal true, validator.valid?

    validator.error_messages = [1, 2, 3, 4, 5]
    assert_equal false, validator.valid?
  end
end
