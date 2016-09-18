require_relative '../../../../test_helper'
require_relative '../../../../../lib/automation_object/blue_print/hash_adapter/helpers/validation_helper'

# TODO, finish unit testing
# Test AutomationObject::BluePrint::HashAdapter::ValidationHelper
class TestBluePrintHashAdapterValidationHelper < Minitest::Test
  def setup
    @composite_stub = stub
    @composite_stub.class.send(:include, AutomationObject::BluePrint::HashAdapter::ValidationHelper)
  end

  def teardown
  end

  def test_errors
    assert_instance_of Array, @composite_stub.errors
    assert_empty @composite_stub.errors

    @composite_stub.errors.push('test error')
    assert_equal ['test error'], @composite_stub.errors
  end

  def test_add_errors
    @composite_stub.add_errors(['test error'])
    assert_equal ['test error'], @composite_stub.errors
  end

  def test_skip_validations
    assert_false @composite_stub.class.skip_validations
    @composite_stub.class.skip_validations = true

    assert_true @composite_stub.class.skip_validations
  end

  def test_validations
    assert_instance_of Array, @composite_stub.class.validations
    assert_empty @composite_stub.class.validations
  end
end
