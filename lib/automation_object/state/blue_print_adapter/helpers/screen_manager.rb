require_relative '../../error'

module AutomationObject
  module State
    module BluePrintAdapter
      #Manages the driver windows
      module ScreenManager
        def window_screens
          @windows_screens = {} unless @windows_screens
          return @windows_screens
        end

        def create
          self.driver.close_other_windows
          @window_handle = self.driver.window_handle
        end

        def set_screen(screen)
          self.window_screens[screen] = @window_handle
          @current_screen = screen
        end

        def request_screen(screen)
          unless self.window_screens.keys.include?(screen)
            raise AutomationObject::State::ScreenDoesNotExistError.new
          end

          return if @window_handle == self.window_screens[screen]

          self.driver.window_handle = self.window_screens[screen]
          @window_handle = self.window_screens[screen]
          @current_screen = screen
        end

        def request_modal(modal)
        end

        #TODO: add modal or screen logic!
        def current_composite
          return self.screens[@current_screen]
        end

        def request_object(type, name)
          object = nil

          case type
            when :element
              object = self.current_composite.elements[name]
            when :element_array
              ap self.current_composite
              object = self.current_composite.element_arrays[name]
            when :element_hash
              object = self.current_composite.element_hashes[name]
            when :element_group
              object = self.current_composite.element_groups[name]
          end

          return object.load
        end
      end
    end
  end
end