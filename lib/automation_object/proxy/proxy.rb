module AutomationObject
  module Proxy
    #Base Proxy class for getting between another
    class Proxy
      instance_methods.each { |instance_method|
        unless instance_method =~ /(^__|^send$|^object_id)/
          undef_method instance_method
        end
      }

      # @param [Object] subject
      def initialize(subject)
        @subject = subject
      end

      # @param [Symbol] method
      # @param [Array, nil] args
      # @param [Proc] block
      def method_missing(method, *args, &block)
        return @subject.send(method, *args, &block)
      end
    end
  end
end