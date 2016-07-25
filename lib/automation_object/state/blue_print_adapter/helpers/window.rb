module AutomationObject
  module State
    module BluePrintAdapter
      class Window
        attr_accessor :name, :window_handle, :previous_window, :driver, :active_modal

        def initialize(args = {})
          self.name = args.fetch :name
          self.driver = args.fetch :driver
          self.window_handle = args.fetch :window_handle

          self.previous_window = args.fetch :previous_window, nil
        end

        # @return [Symbol, nil] name of screen or nil
        def previous_screen_name
          return (self.previous_window) ? self.previous_window.name : nil
        end

        #Change properties to the previous window if it exists
        def back
          return unless self.previous_window

          self.name = self.previous_window.name

          if self.previous_window.previous_window
            self.previous_window = self.previous_window.previous_window
          else
            self.previous_window = nil
          end
        end

        def closed?
          return !self.driver.window_handles.include?(self.window_handle)
        end
      end
    end
  end
end