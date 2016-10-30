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

      def load(type, name)
        case type
        when :screen
          raise AutomationObject::State::ScreenNotActiveError, name unless composite.live_screens.include?(name)

          # Set the current window by name
          composite.use(name)
        when :modal
          raise AutomationObject::State::ModalNotActiveError, name unless composite.window.modal == name
        when :element, :element_array, :element_hash
          return composite.get_object(type, name)
        else
          raise AutomationObject::State::UndefinedLoadTypeError
        end
      end
    end
  end
end
