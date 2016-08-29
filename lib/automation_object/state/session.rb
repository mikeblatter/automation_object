require_relative 'window_manager'
require_relative 'composite/top'

module AutomationObject
  module State
    class Session
      include WindowManager

      attr_accessor :driver, :blue_prints, :composite

      # @param [AutomationObject::Driver::Driver] driver
      # @param [AutomationObject::BluePrint::Composite::Top] blue_prints
      def initialize(driver, blue_prints)
        self.driver = driver
        self.composite = AutomationObject::State::Composite::Top.new(self, driver, blue_prints)

        self.create(self.composite.create)
      end

      def load(type, name)
        case type
          when :screen
            unless self.screens.include?(name)
              raise AutomationObject::State::ScreenNotActiveError.new(name)
            end

            #Set the current window by name
            self.window = name
          when :modal
            unless self.window.modal == name
              raise AutomationObject::State::ModalNotActiveError.new(name)
            end
          when :element, :element_array, :element_hash
            return self.composite.get_object(type, name)
          else
            raise AutomationObject::State::UndefinedLoadTypeError.new
        end
      end
    end
  end
end