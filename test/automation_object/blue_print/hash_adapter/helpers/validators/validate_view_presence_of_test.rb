require_relative '../../../../../test_helper'
require_relative '../../../../../../lib/automation_object/blue_print/hash_adapter/helpers/validators/validate_view_presence_of'

#Test AutomationObject::BluePrint::HashAdapter::Validators::ValidateViewPresenceOf
class TestValidateViewPresenceOf < Minitest::Test
  def setup
    #Shorten it up
    @validator = AutomationObject::BluePrint::HashAdapter::Validators::ValidateViewPresenceOf
  end

  def test_success
    validation_stub = stub(:hash => {
                               :included_views => [:existent_view],
                               :views => {
                                   :existent_view => {}
                               }
                           },
                           :parent => nil,
                           :location => '')

    validator = @validator.new(key: :included_views)
    validator.validate(validation_stub)

    assert_empty validator.error_messages
    assert_equal true, validator.valid?
  end

  def test_success_with_parent
    parent_validation_stub = stub(:hash => {
                                      :views => {
                                          :existent_view => {}
                                      }
                                  },
                                  :parent => nil,
                                  :location => '')
    validation_stub = stub(:hash => {
                               :included_views => [:existent_view],
                           },
                           :parent => parent_validation_stub,
                           :location => '')

    validator = @validator.new(key: :included_views)
    validator.validate(validation_stub)

    assert_empty validator.error_messages
    assert_equal true, validator.valid?
  end

  def test_error
    validation_stub = stub(:hash => {
                               :included_views => [:nonexistent_view],
                               :views => {
                                   :existent_view => {}
                               }
                           },
                           :parent => nil,
                           :location => '')

    validator = @validator.new(key: :included_views)
    validator.validate(validation_stub)

    assert_equal 1, validator.error_messages.length
    assert_equal false, validator.valid?
  end

  def test_error_with_parent
    parent_validation_stub = stub(:hash => {
                                      :views => {
                                          :existent_view => {}
                                      }
                                  },
                                  :parent => nil,
                                  :location => '')
    validation_stub = stub(:hash => {
                               :included_views => [:nonexistent_view],
                           },
                           :parent => parent_validation_stub,
                           :location => '')

    validator = @validator.new(key: :included_views)
    validator.validate(validation_stub)

    assert_equal 1, validator.error_messages.length
    assert_equal false, validator.valid?
  end
end