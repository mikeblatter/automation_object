# frozen_string_literal: true
require_relative '../../../test_helper'

Dir[File.join(File.dirname(__FILE__), '../../../../lib/automation_object/blue_print/**/*.rb')].each { |f| load(f) }

# Common Tests AutomationObject::BluePrint::HashAdapter::
# Using dynamic method addition to make one assertion per function test
module HashAdapterBase
  def setup
    self.class.adapter_class.skip_validations = true
  end

  def teardown
    # Reset skip validations just in case.  Don't want to cause issues when we expect validation exceptions
    self.class.adapter_class.skip_validations = false
  end

  def create_composite(hash = nil, parent = nil)
    return self.class.adapter_class.new(self.class.adapter_class.defaults) if hash.nil?

    adapter = self.class.adapter_class.new(hash, self.class.to_s.downcase.to_sym, parent, self.class.to_s.downcase)
    adapter
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_accessor :adapter_class, :interface_class, :defaults

    def create_tests
      interface_class.public_instance_methods(false).each do |method|
        define_method("test_interface_#{method}") do
          assert create_composite(self.class.defaults).public_methods.include?(method),
                 "#{self.class.adapter_class} should have instance method: #{method}"
        end

        define_method("test_interface_#{method}_arguments") do
          composite = create_composite(self.class.defaults)
          if composite.public_methods.include?(method) && self.class.interface_class.method_defined?(method)
            assert_equal self.class.interface_class.instance_method(method).arity, self.class.adapter_class.instance_method(method).arity
          end
        end
      end

      defaults.each do |method, value|
        define_method("test_default_#{method}") do
          if value.instance_of?(Class)
            assert_instance_of value, self.class.adapter_class.new.send(method)
          else
            target_value = self.class.adapter_class.new.send(method)
            assert target_value.is_a?(value.class)
          end
        end
      end
    end
  end
end
