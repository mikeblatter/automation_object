# frozen_string_literal: true
require_relative 'proxy'

module AutomationObject
  module Proxy
    # Proxy class to throttle methods on the subject
    class ThrottleProxy < Proxy
      def initialize(subject)
        super
      end

      def throttle_methods
        @throttle_methods ||= {}
      end

      def method_missing(method_symbol, *args, &block)
        start_time = Time.new.to_f
        execution_return = @subject.send(method_symbol, *args, &block)
        throttle_speed(method_symbol, start_time)
        execution_return
      end

      def add_method_throttle(method_symbol, time)
        raise ArgumentError, 'Expecting method_symbol argument to be a Symbol' unless method_symbol.is_a?(Symbol)

        raise ArgumentError, 'Expecting time argument to be Numeric' unless time.is_a?(Numeric)

        raise ArgumentError, "Expecting object to respond_to? #{method_symbol}" unless @subject.respond_to?(method_symbol)

        throttle_methods[method_symbol] = time
      end

      # Delete throttle that exists
      # @param method_symbol [Symbol] method symbol to remove throttle from
      def delete_method_throttle(method_symbol)
        throttle_methods.delete(method_symbol)
      end

      # Method to sleep the difference between actual and throttle time
      # @param method_symbol [Symbol] method that is to be throttled
      # @param start_time [Float] start time as float
      # @return [nil]
      def throttle_speed(method_symbol, start_time)
        return unless throttle_methods.key?(method_symbol)
        total_time_taken = Time.new.to_f - start_time

        sleep_time = throttle_methods[method_symbol] - total_time_taken
        sleep(sleep_time) if sleep_time > 0
      end
    end
  end
end
