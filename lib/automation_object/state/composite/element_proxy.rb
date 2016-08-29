require_relative '../../proxy/proxy'

module AutomationObject
  module State
    module Composite
      #Proxy class to allow for usage of hooks
      class ElementProxy < AutomationObject::Proxy::Proxy
        def initialize(args = {})
          @composite = args.fetch :composite
          @subject = args.fetch :element
        end

        #Overiding base method to run possible hooks
        def method_missing(method_symbol, *args, &block)
          #Run before hook if needed
          @composite.method_hooks[method_symbol].before if @composite.method_hook?(method_symbol)

          subject_return = @subject.send(method_symbol, *args, &block)

          #Run after hook if needed
          @composite.method_hooks[method_symbol].after if @composite.method_hook?(method_symbol)

          return subject_return
        end
      end
    end
  end
end