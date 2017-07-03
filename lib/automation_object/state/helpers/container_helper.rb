# frozen_string_literal: true

module AutomationObject
  module State
    module ContainerHelper
      # Whether or not modal is active
      attr_accessor :active

      # @return [Boolean] screen is active or not
      def active?
        @active ||= false
      end

      # Automatically find a way to go to this screen
      # @return [Boolean]
      def go
        if active?
          utilize
          return true
        end

        AutomaticRouting.new(top, name).route
      end

      # @return [Array<Symbol>]
      def changes
        blue_prints.changes
      end

      # @param name [Symbol] name of container you want to go to
      # @return [AutomationObject::State::Element]
      def element_to_container(name)
        element_name, element_type = blue_prints.element_to_container(name)
        return unless element_name || element_type

        send(element_type)[element_name]
      end

      def reset
        elements.values.map(&:reset)
        element_arrays.values.map(&:reset)
        element_hashes.values.map(&:reset)
      end
    end
  end
end
