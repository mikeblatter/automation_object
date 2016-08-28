require_relative '_proxy'

module AutomationObject
  module Dsl
    class ElementHashProxy < Proxy
      # @param [AutomationObject::BluePrint::Composite::ElementHash] blue_prints
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
          #@subject = @state.load(:element_hash, @name)
        end

        super
      end
    end
  end
end