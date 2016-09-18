require_relative 'window'
require_relative '../../error'

module AutomationObject
  module State
    module Composite
      module WindowManager
        attr_accessor :window, :modal

        def window=(name)
          self.windows.each { |window|
            next if window.name != name
            return if window == self.window

            self.window.use
          }
        end

        # @return [Array<Window>]
        def windows
          @windows ||= []
        end

        # @return [Array<String>] list of stored window handles
        def window_handles
          windows.map { |window| window.handle }
        end

        # @return [Array<String>] list of stored screen names
        def live_screens
          windows.map { |window| window.name }
        end

        def new_window(name)
          driver_handles = self.driver.window_handles
          diff_handles = driver_handles - self.window_handles

          #Should only have one extra window
          if diff_handles.length > 1
            raise UnexpectedExtraWindowError.new
          end

          self.window = Window.new(self.driver, diff_handles.first, name)
          self.windows << self.window
        end
      end
    end
  end
end