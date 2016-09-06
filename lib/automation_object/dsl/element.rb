require_relative '_proxy'

module AutomationObject
  module Dsl
    class Element < Base
    end

    class ElementProxy < Proxy
      # @param [AutomationObject::BluePrint::Composite::Element] blue_prints
      # @param [AutomationObject::State::Session] state
      # @param [Symbol] name
      def initialize(blue_prints, state, name)
        super Element, blue_prints, state, name
      end

      # @param [Symbol] method
      # @param [Array, nil] args
      # @param [Proc] block
      def method_missing(method, *args, &block)
        #If Screen class has the method defined, then don't load
        return super if Element.method_defined?(method)

        if @subject == nil
          puts "@state.load(:element, #{@name})"
          @subject = @state.load(:element, @name)
        end

        super
      end
    end
  end
end