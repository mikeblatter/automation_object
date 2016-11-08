# frozen_string_literal: true
require_relative '_proxy'

module AutomationObject
  module Dsl
    # ElementHash DSL Class
    class ElementHash < Base
    end

    # Proxy for ElementHash
    class ElementHashProxy < Proxy
      # @param [AutomationObject::BluePrint::Composite::ElementHash] blue_prints
      # @param [AutomationObject::State::Session] state
      # @param [Symbol] name
      def initialize(blue_prints, state, name)
        super ElementHash, blue_prints, state, name
      end

      # @param [Symbol] method
      # @param [Array, nil] args
      # @param [Proc] block
      def method_missing(method, *args, &block)
        return super if ElementHash.methods.include?(method)

        if @subject.is_a?(AutomationObject::Dsl::ElementHash)
          #puts "@state.load(:element_hash, #{@name})"
          @subject = @state.load(:element_hash, @name)
        end

        super
      end
    end
  end
end
