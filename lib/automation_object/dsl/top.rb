# frozen_string_literal: true
require_relative '_base'
require_relative '_proxy'
require_relative '_error'

require_relative 'screen'

module AutomationObject
  module Dsl
    # Top DSL Class
    class Top < Base
      has_many :screens, ScreenProxy
    end

    # Proxy for Top Composite
    # Use proxy for methods trying to do a @state call
    class TopProxy < Proxy
      # @param blue_prints [AutomationObject::BluePrint::Composite::Top]
      # @param state [AutomationObject::State::Top] top composite
      # @param name [Symbol]
      def initialize(blue_prints, state, name)
        super Top, blue_prints, state, name
      end

      def active?
        true
      end

      # Retrieve screen from composite
      # @param name [String, Symbol] name of screen
      # @raise [AutomationObject::Dsl::Error::ScreenDoesNotExistError]
      # @return [AutomationObject::Dsl::ScreenProxy]
      def screen(name)
        name = name.to_sym
        raise AutomationObject::Dsl::Error::ScreenDoesNotExistError.new(name) unless @subject.to_h.include?(name)

        @subject.send(name)
      end

      # Current Screen
      # @return [AutomationObject::Dsl::ScreenProxy]
      def current_screen
        @subject.send(@state.current_screen)
      end
    end
  end
end
