# frozen_string_literal: true

require_relative '../../../../../test_helper'
require_relative '../../../../../../lib/automation_object/blue_print/hash_adapter/helpers/validators/validate_screen_presence_of'

# Test AutomationObject::BluePrint::HashAdapter::Validators::ValidateScreenPresenceOf
class TestValidateScreenPresenceOf < Minitest::Test
  def setup
    # Shorten it up
    @validator = AutomationObject::BluePrint::HashAdapter::Validators::ValidateScreenPresenceOf
  end

  def test_success
    validation_stub = stub(hash: {
                             default_screen: :existent_screen,
                             screens: {
                               existent_screen: {}
                             }
                           },
                           parent: nil,
                           location: '')

    validator = @validator.new(key: :default_screen)
    validator.validate(validation_stub)

    assert_empty validator.error_messages
    assert_equal true, validator.valid?
  end

  def test_success_with_parent
    parent_validation_stub = stub(hash: {
                                    screens: {
                                      existent_screen: {}
                                    }
                                  },
                                  parent: nil,
                                  location: '')
    validation_stub = stub(hash: {
                             default_screen: :existent_screen
                           },
                           parent: parent_validation_stub,
                           location: '')

    validator = @validator.new(key: :default_screen)
    validator.validate(validation_stub)

    assert_empty validator.error_messages
    assert_equal true, validator.valid?
  end

  def test_error
    validation_stub = stub(hash: {
                             default_screen: :nonexistent_screen,
                             screens: {
                               existent_screen: {}
                             }
                           },
                           parent: nil,
                           location: '')

    validator = @validator.new(key: :default_screen)
    validator.validate(validation_stub)

    assert_equal 1, validator.error_messages.length
    assert_equal false, validator.valid?
  end

  def test_error_with_parent
    parent_validation_stub = stub(hash: {
                                    screens: {
                                      existent_screen: {}
                                    }
                                  },
                                  parent: nil,
                                  location: '')
    validation_stub = stub(hash: {
                             default_screen: :nonexistent_screen
                           },
                           parent: parent_validation_stub,
                           location: '')

    validator = @validator.new(key: :default_screen)
    validator.validate(validation_stub)

    assert_equal 1, validator.error_messages.length
    assert_equal false, validator.valid?
  end
end
