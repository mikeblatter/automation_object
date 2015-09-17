require_relative '../../../../test_helper'
require_relative '../../../../../lib/automation_object/blue_print/hash_adapter/validators/validate_presence_of'

#Test AutomationObject::BluePrint::HashAdapter::Validators::ValidatePresenceOf
#Test for presence success and error
class TestValidatePresenceOf < Minitest::Test
  def setup
    #Shorten it up
    @validator = AutomationObject::BluePrint::HashAdapter::Validators::ValidatePresenceOf
    @validation_stub = stub(
        :location => 'test',
        :hash => {
            :existent => true
        }
    )
  end

  def test_success
    validator = @validator.new(key: :existent)
    validator.validate(@validation_stub)

    assert_empty validator.error_messages
    assert_equal true, validator.valid?
  end

  def test_success_unless_presence_of
    validator = @validator.new(key: :nonexistent, args: { :unless_presence_of => :existent })
    validator.validate(@validation_stub)

    assert_empty validator.error_messages
    assert_equal true, validator.valid?
  end

  def test_error
    validator = @validator.new(key: :nonexistent)
    validator.validate(@validation_stub)

    assert_equal 1, validator.error_messages.length
    assert_equal false, validator.valid?
  end

  def test_error_unless_presence_of
    validator = @validator.new(key: :nonexistent, args: { :unless_presence_of => :nonexistent_two })
    validator.validate(@validation_stub)

    assert_equal 1, validator.error_messages.length
    assert_equal false, validator.valid?
  end
end