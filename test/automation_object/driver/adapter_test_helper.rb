# frozen_string_literal: true

require_relative '../../test_helper'

Dir['../../../lib/automation_object/driver/**/*.rb'].each { |f| load(f) }

module AdapterTestHelper
  def setup; end

  def teardown; end

  def create_adapter
    self.class.adapter_class.new(stub)
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_accessor :adapter_class, :interface_class

    def create_tests
      interface_class.public_instance_methods(false).each do |method|
        remove_method :"test_interface_#{method}" if method_defined? :"test_interface_#{method}"
        define_method("test_interface_#{method}") do
          assert self.class.adapter_class.public_instance_methods(true).include?(method),
                 "#{self.class.adapter_class} should have instance method: #{method}"
        end
      end
    end
  end
end
