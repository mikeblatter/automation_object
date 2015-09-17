require_relative '../../test_helper'

#Test AutomationObject::Driver::NokogiriAdapter
class TestNokogiriAdapter < Minitest::Test
  def setup
    AutomationObject::Driver.adapter = :nokogiri
  end

  def test_new
    assert_instance_of AutomationObject::Driver::NokogiriAdapter::Driver, AutomationObject::Driver.new
  end
end