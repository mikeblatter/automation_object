# frozen_string_literal: true

require_relative 'proxy'

module AutomationObject
  module Proxy
    # Proxy class for protecting object with Mutex
    class MutexProxy < Proxy
      def initialize(subject)
        super

        @mutexes = [Mutex.new]
        @skip_protection_classes = [TrueClass, FalseClass, String, Numeric, Array, Hash, Class, NilClass, Symbol]
      end

      def add_mutex(mutex_object)
        raise ArgumentError, 'Expecting mutex_object argument to be a Mutex object' unless mutex_object.is_a?(Mutex)

        @mutexes << mutex_object
      end

      def delete_mutex(mutex_object)
        raise ArgumentError, 'Expecting mutex_object argument to be a Mutex object' unless mutex_object.is_a?(Mutex)

        @mutexes.delete(mutex_object)
      end

      def method_missing(method_symbol, *args, &block)
        exec_procedures = []
        exec_procedures.push(lambda do
          execution_return = @subject.send(method_symbol, *args, &block)
          return protect_object(execution_return)
        end)

        index = 0
        @mutexes.each do |mutex|
          index += 1
          exec_procedures.push(lambda do
            mutex.synchronize do
              index -= 1
              exec_procedures[index].call
            end
          end)
        end

        exec_procedures.last.call
      end

      def protect_object(object)
        return object if @skip_protection_classes.include?(object.class)

        protected_object = MutexProxy.new(object)

        @mutexes.each do |mutex|
          protected_object.add_mutex(mutex)
        end

        protected_object
      end
    end
  end
end
