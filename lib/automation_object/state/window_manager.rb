require_relative 'error'

module AutomationObject
  module State
    #Manages the driver windows
    class WindowManager
      def initialize(args = {})
        @driver = args.fetch(:driver)
        @composite = args.fetch(:composite)

        @windows_screens = {}
        @current_screen = nil
      end

      def create
        @driver.close_other_windows
        @window_handle = @driver.window_handle
      end

      def set_screen(screen)
        @windows_screens[screen] = @window_handle
        @current_screen = screen
      end

      def use_screen(screen)
        unless @windows_screens.keys.include?(screen)
          raise AutomationObject::State::ScreenDoesNotExistError.new
        end

        return if @window_handle == @windows_screens[screen]

        @driver.window_handle = @windows_screens[screen]
        @window_handle = @windows_screens[screen]
        @current_screen = screen
      end

      # Either a modal or screen depending on what has already been requested
      # @return [AutomationObject::State::BluePrintAdapter::Screen, AutomationObject::State::BluePrintAdapter::Modal]
      def current_composite
        return @composite.screens[@current_screen]
      end

      def get_object(type, name)
        object = nil

        case type
          when :element
            object = self.current_composite.elements[name].load
          when :element_array
            object = self.current_composite.element_arrays[name].load
          when :element_hash
            object = self.current_composite.element_hashes[name].load
          when :element_group
            object = self.current_composite.element_groups[name].load
        end

        return object
      end

      def destroy
        #@driver.close_other_windows
      end
    end
  end
end