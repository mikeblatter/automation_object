require_relative '../../../test_helper'

require_relative '../../../../lib/automation_object/driver/nokogiri_adapter/element'
require_relative '../../../../lib/automation_object/driver/element'

#Test AutomationObject::Driver::NokogiriAdapter::Element class
class TestNokogiriAdapterElement < Minitest::Test
  def setup
  end

  #Nokogiri Driver should have all Driver interface methods
  #Use reflection to add multiple test functions so we can capture each failure
  AutomationObject::Driver::Element.public_instance_methods(false).each do |instance_method|
    define_method("test_interface_#{instance_method}") do
      assert AutomationObject::Driver::NokogiriAdapter::Element.public_instance_methods.include?(instance_method),
             "AutomationObject::Driver::NokogiriAdapter::Element should have instance method: #{instance_method}"
    end
  end
end