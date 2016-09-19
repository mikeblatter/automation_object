# frozen_string_literal: true
require_relative '../proxy/proxy'

module AutomationObject
  module Dsl
    class Proxy < AutomationObject::Proxy::Proxy
      # @param [AutomationObject::Dsl::CompositeBase, nil] subject
      # @param [AutomationObject::BluePrint::Composite::CompositeBase] blue_prints
      # @param [AutomationObject::State::Session] state
      # @param [Symbol] name
      def initialize(subject, blue_prints, state, name)
        @blue_prints = blue_prints
        @state = state
        @name = name

        @subject = (subject.new(blue_prints, state) if subject)
      end
    end
  end
end
