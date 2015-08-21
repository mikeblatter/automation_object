require_relative 'proxy'

module AutomationObject
  module Proxies
    #Proxy class to throttle methods on the subject
    class ThrottleProxy < Proxy
      def initialize(subject)
        super
      end

      def throttle_methods
        @throttle_methods ||= Hash.new
      end

      def method_missing(method_symbol, *args, &block)
        start_time = Time.new.to_f
        execution_return = @subject.send(method_symbol, *args, &block)
        self.throttle_speed(method_symbol, start_time)
        return execution_return
      end

      def add_method_throttle(method_symbol, time)
        unless method_symbol.is_a?(Symbol)
          raise ArgumentError, 'Expecting method_symbol argument to be a Symbol'
        end

        unless time.is_a?(Numeric)
          raise ArgumentError, 'Expecting time argument to be Numeric'
        end

        unless @subject.respond_to?(method_symbol)
          raise ArgumentError, "Expecting object to respond_to? #{method_symbol}"
        end

        self.throttle_methods[method_symbol] = time
      end

      #Delete throttle that exists
      # @param method_symbol [Symbol] method symbol to remove throttle from
      def delete_method_throttle(method_symbol)
        self.throttle_methods.delete(method_symbol)
      end

      #Method to sleep the difference between actual and throttle time
      # @param method_symbol [Symbol] method that is to be throttled
      # @param start_time [Float] start time as float
      # @return [nil]
      def throttle_speed(method_symbol, start_time)
        return unless self.throttle_methods.has_key?(method_symbol)
        total_time_taken = Time.new.to_f - start_time

        sleep_time = self.throttle_methods[method_symbol] - total_time_taken
        sleep(sleep_time) if sleep_time > 0
      end
    end
  end
end