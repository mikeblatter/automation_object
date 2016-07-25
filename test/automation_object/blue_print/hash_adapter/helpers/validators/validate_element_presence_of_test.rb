require_relative '../../../../../test_helper'
require_relative '../../../../../../lib/automation_object/blue_print/hash_adapter/helpers/validators/validate_element_presence_of'

#Test AutomationObject::BluePrint::HashAdapter::Validators::ValidateElementPresenceOf
class TestValidateElementPresenceOf < Minitest::Test
  def setup
    #Shorten it up
    @validator = AutomationObject::BluePrint::HashAdapter::Validators::ValidateElementPresenceOf
  end

  def test_success
    validation_stub = stub(:hash => {
                               :link_to_element => :existent_element,
                               :elements => {
                                   :existent_element => {}
                               }
                           },
                           :parent => nil,
                           :location => '')


    validator = @validator.new(key: :link_to_element)
    validator.validate(validation_stub)

    assert_empty validator.error_messages
    assert_equal true, validator.valid?
  end

  def test_success_with_parent
    parent_validation_stub = stub(:hash => {
                                      :elements => {
                                          :existent_element => {}
                                      }
                                  },
                                  :parent => nil,
                                  :location => '')
    validation_stub = stub(:hash => {
                               :link_to_element => :existent_element,
                           },
                           :parent => parent_validation_stub,
                           :location => '')

    validator = @validator.new(key: :link_to_element)
    validator.validate(validation_stub)

    assert_empty validator.error_messages
    assert_equal true, validator.valid?
  end

  def test_error
    validation_stub = stub(:hash => {
                               :link_to_element => :nonexistent_element,
                               :elements => {
                                   :existent_element => {}
                               }
                           },
                           :parent => nil,
                           :location => '')

    validator = @validator.new(key: :link_to_element)
    validator.validate(validation_stub)

    assert_equal 1, validator.error_messages.length
    assert_equal false, validator.valid?
  end

  def test_error_with_parent
    parent_validation_stub = stub(:hash => {
                                      :elements => {
                                          :existent_element => {}
                                      }
                                  },
                                  :parent => nil,
                                  :location => '')
    validation_stub = stub(:hash => {
                               :link_to_element => :nonexistent_element,
                           },
                           :parent => parent_validation_stub,
                           :location => '')

    validator = @validator.new(key: :link_to_element)
    validator.validate(validation_stub)

    assert_equal 1, validator.error_messages.length
    assert_equal false, validator.valid?
  end
end