require_relative '../../test_helper'

#Test AutomationObject::Driver::AppiumAdapter
class TestAppiumAdapter < Minitest::Test
  def setup
    AutomationObject::Driver.adapter = :appium
  end

  def test_new
    assert_instance_of Object, AutomationObject::Driver.new(Object.new)
  end
end