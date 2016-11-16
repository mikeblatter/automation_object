# frozen_string_literal: true
require_relative 'error'

require_relative 'composite/top'

module AutomationObject
  module State
    # Session manages the DSL state
    class Session
      # @return [AutomationObject::Driver::Driver]
      attr_accessor :driver

      # @return [AutomationObject::BluePrint::Composite::Top]
      attr_accessor :blue_prints

      # @return [AutomationObject::State::Composite::Top]
      attr_accessor :composite

      # @param [AutomationObject::Driver::Driver] driver
      # @param [AutomationObject::BluePrint::Composite::Top] blue_prints
      def initialize(driver, blue_prints)
        self.driver = driver
        self.composite = Composite::Top.new(self, driver, blue_prints)
      end

      # @param type [Symbol]
      # @param name [Symbol]
      def load(type, name)
        case type
        when :screen
          composite.use(name)
        when :modal
          composite.current_screen.use(name)
        when :element, :element_array, :element_hash
          return composite.current_screen.get(type, name)
        else
          raise AutomationObject::State::UndefinedLoadTypeError
        end
      end

      # @param type [Symbol]
      # @param name [Symbol]
      # @return [Boolean]
      def active?(type, name)
        case type
        when :screen
          composite.live_screens.include?(name)
        else
          raise AutomationObject::State::UndefinedLoadTypeError
        end
      end
    end
  end
end
