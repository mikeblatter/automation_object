# frozen_string_literal: true
require_relative '../../../../../test_helper'
require_relative '../../../../../../lib/automation_object/blue_print/hash_adapter/helpers/validators/validate_instance_of'

# Class to use for unit testing
class MockForTestValidateInstanceOf
  attr_accessor :location

  def hash
    {
      string: 'test',
      integer: 0,
      float: 0.1,
      hash: {},
      array: []
    }
  end

  def hash_classes
    new_hash = {}
    hash.each_key do |key|
      new_hash[key] = Kernel.const_get(key.to_s.capitalize)
    end

    new_hash
  end
end

# Test AutomationObject::BluePrint::HashAdapter::Validators::ValidateInstanceOf
# Each test method below tests each @hash key of MockForTestValidateInstanceOf for success and failure
class TestValidateInstanceOf < Minitest::Test
  def setup
    # Shorten it up
    @validator = AutomationObject::BluePrint::HashAdapter::Validators::ValidateInstanceOf

    # Make Mock
    @mock = MockForTestValidateInstanceOf.new
  end

  def test_success
    @mock.hash.each_key do |key_to_test|
      validator = @validator.new(key: key_to_test, args: @mock.hash_classes[key_to_test])
      validator.validate(@mock)
      assert_empty validator.error_messages

      # Test them all in an array of classes
      validator = @validator.new(key: key_to_test, args: @mock.hash_classes.values)
      validator.validate(@mock)

      assert_empty validator.error_messages
      assert_equal true, validator.valid?
    end
  end

  def test_error
    @mock.hash.each_key do |key_to_test|
      # Need to remove the should be in order to continue and test raises
      class_should_be = @mock.hash_classes[key_to_test]
      classes_should_not_be = @mock.hash_classes.values - [class_should_be]

      # Use a random class it should not be and assert raises
      classes_should_not_be.each do |class_should_not_be|
        validator = @validator.new(key: key_to_test, args: class_should_not_be)
        validator.validate(@mock)
        assert_equal 1, validator.error_messages.length
      end

      # Test them all in an array of classes
      validator = @validator.new(key: key_to_test, args: classes_should_not_be)
      validator.validate(@mock)

      assert_equal 1, validator.error_messages.length
      assert_equal false, validator.valid?
    end
  end
end
