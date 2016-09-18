require_relative '../../test_helper'

Dir['../../../lib/automation_object/driver/**/*.rb'].each { |f| load(f) }

# Common Tests AutomationObject::BluePrint::HashAdapter::
# Using dynamic method addition to make one assertion per function test
module AdapterTestHelper
  def setup
  end

  def teardown
  end

  def create_adapter
    self.class.adapter_class.new(stub())
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_accessor :adapter_class, :interface_class

    def create_tests
      self.interface_class.public_instance_methods(false).each do |method|
        define_method("test_interface_#{method}") do
          assert self.class.adapter_class.public_instance_methods(true).include?(method),
                 "#{self.class.adapter_class} should have instance method: #{method}"
        end

        # define_method("test_interface_#{method}_arguments") do
        # adapter = create_adapter
        # if adapter.public_methods.include?(method) and self.class.interface_class.method_defined?(method)
        # assert_equal self.class.interface_class.instance_method(method).arity, self.class.adapter_class.instance_method(method).arity
        # end
        # end
      end
    end
  end
end
