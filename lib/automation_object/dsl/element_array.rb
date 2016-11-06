# frozen_string_literal: true
require_relative '_proxy'

module AutomationObject
  module Dsl
    # ElementArray DSL Class
    class ElementArray < Base
    end

    # Proxy for ElementArray
    class ElementArrayProxy < Proxy
      # @param [AutomationObject::BluePrint::Composite::ElementArray] blue_prints
      # @param [AutomationObject::State::Session] state
      # @param [Symbol] name
      def initialize(blue_prints, state, name)
        super ElementArray, blue_prints, state, name
      end

      # @param [Symbol] method
      # @param [Array, nil] args
      # @param [Proc] block
      def method_missing(method, *args, &block)
        return super if ElementArray.methods.include?(method)

        if @subject.nil?
          puts "@state.load(:element_array, #{@name})"
          @subject = @state.load(:element_array, @name)
        end

        super
      end
    end
  end
end
