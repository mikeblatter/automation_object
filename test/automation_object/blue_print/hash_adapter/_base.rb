require_relative '../../../test_helper'

Dir['../../../../lib/automation_object/blue_print/**/*.rb'].each { |f| load(f) }

#Common Tests AutomationObject::BluePrint::HashAdapter::
#Using dynamic method addition to make one assertion per function test
module HashAdapterBase
  def setup
    self.class::ADAPTER_CLASS.skip_validations = true
  end

  def teardown
    #Reset skip validations just in case.  Don't want to cause issues when we expect validation exceptions
    self.class::ADAPTER_CLASS.skip_validations = false
  end

  def create_composite(hash = nil)
    return self.class::ADAPTER_CLASS.new(self.class::ADAPTER_CLASS.defaults) if hash == nil
    self.class::ADAPTER_CLASS.new(hash)
  end

  def self.included(base)
    adapter_class = base::ADAPTER_CLASS
    interface_class = base::INTERFACE_CLASS
    defaults = base::DEFAULTS

    adapter_class.public_instance_methods(false).each do |method|
      define_method("test_interface_#{method}") do
        assert create_composite(defaults).public_methods.include?(method),
               "#{adapter_class} should have instance method: #{method}"
      end

      define_method("test_interface_#{method}_arguments") do
        composite = create_composite(defaults)
        if composite.public_methods.include?(method)
          assert_equal interface_class.instance_method(method).arity, adapter_class.instance_method(method).arity
        end
      end
    end

    defaults.each do |method, value|
      define_method("test_default_#{method}") do
        if value.instance_of?(Class)
          assert_instance_of value, adapter_class.new.send(method)
        else
          target_value = adapter_class.new.send(method)
          assert target_value.is_a?(value.class)
        end
      end
    end
  end
end