module AutomationObject
  module State
    module BluePrintAdapter
      module ScreenManager
        Window = Struct.new(:name, :window_handle)

        # @return [Array<Window>]
        def windows
          @windows ||= []
        end

        # @return [Array<String>] list of stored window handles
        def window_handles
          handles = []
          self.windows.each { |window|
            handles.push(window.window_handle)
          }
          return handles
        end

        def set_screen(name)
          current_window_handle = self.driver.window_handle

          self.windows.each { |window|
            if window.window_handle == current_window_handle
              self.windows.delete(window)
              break
            end
          }

          self.windows << Window.new(name, current_window_handle)
        end

        def create_screen(name)
          driver_handles = self.driver.window_handles
          diff_handles = self.window_handles - driver_handles

          #Should only have one extra window
          if diff_handles.length > 1
            raise "Expecting only one extra window, got #{diff_handles.length}"
          end

          self.windows << Window.new(name, diff_handles.first)
        end

        def use_screen(name)
          current_window_handle = self.driver.window_handle
          self.windows.each { |window|
            next unless window.name == name

            break if window.window_handle == current_window_handle

            self.driver.window_handle = window.window_handle
          }

          @current_screen = name
        end

        def delete_screen(name)
          self.windows.each { |window|
            self.windows.delete(name) if window.name == name
          }
        end

        def screen_exists?(name)
          self.windows.each { |window|
            return true if window.name == name
          }

          return false
        end

        def current_composite
          return self.screens[@current_screen]
        end

        def get_object(type, name)
          object = nil

          case type
            when :element
              object = self.current_composite.elements[name]
            when :element_array
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