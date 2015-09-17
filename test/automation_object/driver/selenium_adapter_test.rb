require_relative '../../test_helper'

#Test AutomationObject::Driver::SeleniumAdapter
class TestSeleniumAdapter < Minitest::Test
  def setup
    AutomationObject::Driver.adapter = :selenium
  end

  def test_new
    assert_instance_of Object, AutomationObject::Driver.new(Object.new)
  end
end