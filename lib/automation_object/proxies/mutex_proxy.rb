require_relative 'proxy'

module AutomationObject
  module Proxies
    #Proxy class for protecting object with Mutex
    class MutexProxy < Proxy
      def initialize(subject)
        super

        @mutexes = [Mutex.new]
        @skip_protection_classes = [TrueClass, FalseClass, String, Numeric, Array, Hash, Class, NilClass, Symbol]
      end

      def add_mutex(mutex_object)
        unless mutex_object.is_a?(Mutex)
          raise ArgumentError, 'Expecting mutex_object argument to be a Mutex object'
        end

        @mutexes << mutex_object
      end

      def delete_mutex(mutex_object)
        unless mutex_object.is_a?(Mutex)
          raise ArgumentError, 'Expecting mutex_object argument to be a Mutex object'
        end

        @mutexes.delete(mutex_object)
      end

      def method_missing(method_symbol, *args, &block)
        exec_procedures = Array.new
        exec_procedures.push(lambda {
          execution_return = @subject.send(method_symbol, *args, &block)
          return self.protect_object(execution_return)
        })

        index = 0
        @mutexes.each { |mutex|
          index += 1
          exec_procedures.push(lambda {
            mutex.synchronize do
              index -= 1
              exec_procedures[index].call
            end
          })
        }

        return exec_procedures.last.call
      end

      def protect_object(object)
        return object if @skip_protection_classes.include?(object.class)
        protected_object = MutexProxy.new(object)

        @mutexes.each { |mutex|
          protected_object.add_mutex(mutex)
        }

        return protected_object
      end
    end
  end
end