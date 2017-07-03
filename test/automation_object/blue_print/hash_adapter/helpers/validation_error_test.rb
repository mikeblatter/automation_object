# frozen_string_literal: true

require_relative '../../../../test_helper'
require_relative '../../../../../lib/automation_object/blue_print/hash_adapter/helpers/validation_error'

# Test AutomationObject::BluePrint::HashAdapter::Validators::ValidationError
class TestValidationError < Minitest::Test
  def setup
    @validation_error_class = AutomationObject::BluePrint::HashAdapter::ValidationError
  end

  def test_errors
    validation_error = @validation_error_class.new('test')
    assert_equal ['test'], validation_error.errors

    validation_error = @validation_error_class.new(%w[test test_two])
    assert_equal %w[test test_two], validation_error.errors
  end
end
