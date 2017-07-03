# frozen_string_literal: true

require_relative '../../../../../test_helper'
require_relative '../../../../../../lib/automation_object/blue_print/hash_adapter/helpers/validators/validate_modal_presence_of'

# Test AutomationObject::BluePrint::HashAdapter::Validators::ValidateModalPresenceOf
class TestValidateModalPresenceOf < Minitest::Test
  def setup
    @validator = AutomationObject::BluePrint::HashAdapter::Validators::ValidateModalPresenceOf
  end

  def test_success
    validation_stub = stub(hash: {
                             link_to_modal: :existent_modal,
                             modals: {
                               existent_modal: {}
                             }
                           },
                           parent: nil,
                           location: '')

    validator = @validator.new(key: :link_to_modal)
    validator.validate(validation_stub)

    assert_empty validator.error_messages
    assert_equal true, validator.valid?
  end

  def test_success_with_parent
    parent_validation_stub = stub(hash: {
                                    modals: {
                                      existent_modal: {}
                                    }
                                  },
                                  parent: nil,
                                  location: '')
    validation_stub = stub(hash: {
                             link_to_modal: :existent_modal
                           },
                           parent: parent_validation_stub,
                           location: '')

    validator = @validator.new(key: :link_to_modal)
    validator.validate(validation_stub)

    assert_empty validator.error_messages
    assert_equal true, validator.valid?
  end

  def test_error
    validation_stub = stub(hash: {
                             link_to_modal: :nonexistent_modal,
                             modals: {
                               existent_modal: {}
                             }
                           },
                           parent: nil,
                           location: '')

    validator = @validator.new(key: :link_to_modal)
    validator.validate(validation_stub)

    assert_equal 1, validator.error_messages.length
    assert_equal false, validator.valid?
  end

  def test_error_with_parent
    parent_validation_stub = stub(hash: {
                                    modals: {
                                      existent_modal: {}
                                    }
                                  },
                                  parent: nil,
                                  location: '')
    validation_stub = stub(hash: {
                             link_to_modal: :nonexistent_modal
                           },
                           parent: parent_validation_stub,
                           location: '')

    validator = @validator.new(key: :link_to_modal)
    validator.validate(validation_stub)

    assert_equal 1, validator.error_messages.length
    assert_equal false, validator.valid?
  end
end
