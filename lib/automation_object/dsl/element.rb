require_relative '_proxy'

module AutomationObject
  module Dsl
    class ElementProxy < Proxy
      # @param [AutomationObject::BluePrint::Composite::Element] blue_prints
      # @param [AutomationObject::State::Session] state
      # @param [Symbol] name
      def initialize(blue_prints, state, name)
        super nil, blue_prints, state, name
      end

      # @param [Symbol] method
      # @param [Array, nil] args
      # @param [Proc] block
      def method_missing(method, *args, &block)
        #If subject is null, then load it
        if @subject == nil
          puts "@state.load(:element, #{@name})"
          #@subject = @state.load(:element, @name)
        end

        super
      end
    end
  end
end