# frozen_string_literal: true
require_relative '../../proxy/proxy'

module AutomationObject
  module State
    module Composite
      # Proxy class to allow for usage of hooks
      class ElementProxy < ::AutomationObject::Proxy::Proxy
        def initialize(composite, element)
          @composite = composite
          @subject = element
        end

        # Overiding base method to run possible hooks
        def method_missing(method_symbol, *args, &block)
          # Run before hook if needed
          @composite.method_hooks[method_symbol].before if @composite.method_hook?(method_symbol)

          subject_return = @subject.send(method_symbol, *args, &block)

          # Run after hook if needed
          @composite.method_hooks[method_symbol].after if @composite.method_hook?(method_symbol)

          subject_return
        end

        def respond_to_missing?(method, include_private = false)
          @subject.respond_to_missing?(method, include_private)
        end
      end
    end
  end
end
