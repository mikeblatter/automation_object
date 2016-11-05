# frozen_string_literal: true
require_relative '../proxy/proxy'

module AutomationObject
  module Dsl
    # Base Proxy Object
    # Proxies intercept commands and issue calls to the state
    # Prevents inspection from picking up internal methods
    class Proxy < AutomationObject::Proxy::Proxy
      # @param subject_class [AutomationObject::Dsl::CompositeBase, nil]
      # @param blue_prints [AutomationObject::BluePrint::Composite::CompositeBase]
      # @param state [AutomationObject::State::Session]
      # @param name [Symbol]
      def initialize(subject_class, blue_prints, state, name)
        @blue_prints = blue_prints
        @state = state
        @name = name
        @subject_class = subject_class

        @subject = (@subject_class.new(blue_prints, state))
      end
    end
  end
end
