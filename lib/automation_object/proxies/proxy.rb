module AutomationObject
  module Proxies
    #Base Proxy class for getting between another
    class Proxy
      instance_methods.each { |instance_method|
        unless instance_method =~ /(^__|^send$|^object_id)/
          undef_method instance_method
        end
      }

      def initialize(subject)
        @subject = subject
      end

      def method_missing(method_symbol, *args, &block)
        return @subject.send(method_symbol, *args, &block)
      end
    end
  end
end