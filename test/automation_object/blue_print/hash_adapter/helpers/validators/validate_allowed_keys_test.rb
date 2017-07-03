# frozen_string_literal: true

require_relative '../../../../../test_helper'
require_relative '../../../../../../lib/automation_object/blue_print/hash_adapter/helpers/validators/validate_allowed_keys'

# Test AutomationObject::BluePrint::HashAdapter::Validators::ValidateAllowedKeys
class TestValidateAllowedKeys < Minitest::Test
  def setup
    @validator = AutomationObject::BluePrint::HashAdapter::Validators::ValidateAllowedKeys
    @validation_stub = stub(hash: {
                              test_key_one: 1,
                              test_key_two: 2
                            }, location: 'composite_location.friendly_format')
  end

  def test_success
    validator = @validator.new(allowed_keys: %i[test_key_one test_key_two])
    validator.validate(@validation_stub)

    assert_empty validator.error_messages
    assert_equal true, validator.valid?
  end

  def test_error
    validator = @validator.new(allowed_keys: [:test_key_one])
    validator.validate(@validation_stub)
    assert_equal 1, validator.error_messages.length

    validator = @validator.new(allowed_keys: [])
    validator.validate(@validation_stub)

    assert_equal 2, validator.error_messages.length
    assert_equal false, validator.valid?
  end
end
