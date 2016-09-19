# frozen_string_literal: true
module AutomationObject
  module Proxy
    # CompositeBase Proxy class for getting between another
    class Proxy
      instance_methods.each do |instance_method|
        undef_method instance_method unless instance_method =~ /(^__|^send$|^object_id)/
      end

      # @param [Object] subject
      def initialize(subject)
        @subject = subject
      end

      # @param [Symbol] method
      # @param [Array, nil] args
      # @param [Proc] block
      def method_missing(method, *args, &block)
        @subject.send(method, *args, &block)
      end

      def respond_to_missing?(method, include_private = false)
        @subject.respond_to_missing?(method, include_private)
      end
    end
  end
end
