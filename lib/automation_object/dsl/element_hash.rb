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
        # If Screen class has the method defined, then don't load
        return super if ElementHash.method_defined?(method)

        if @subject.nil?
          puts "@state.load(:element_hash, #{@name})"
          @subject = @state.load(:element_hash, @name)
        end

        super
      end
    end
  end
end
