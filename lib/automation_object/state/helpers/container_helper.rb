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

        AutomaticRouting.new(self.top, self.name).route
      end

      # @return [Array<Symbol>]
      def changes
        blue_prints.changes
      end

      def reset
        elements.values.map(&:reset)
        element_arrays.values.map(&:reset)
        element_hashes.values.map(&:reset)
      end
    end
  end
end
