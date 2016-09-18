require_relative 'window'
require_relative '../../error'

module AutomationObject
  module State
    module Composite
      module WindowManager
        attr_accessor :window, :modal

        def window=(name)
          windows.each do |window|
            next if window.name != name
            return if window == self.window

            self.window.use
          end
        end

        # @return [Array<Window>]
        def windows
          @windows ||= []
        end

        # @return [Array<String>] list of stored window handles
        def window_handles
          windows.map(&:handle)
        end

        # @return [Array<String>] list of stored screen names
        def live_screens
          windows.map(&:name)
        end

        def new_window(name)
          driver_handles = driver.window_handles
          diff_handles = driver_handles - window_handles

          # Should only have one extra window
          raise UnexpectedExtraWindowError if diff_handles.length > 1

          self.window = Window.new(driver, diff_handles.first, name)
          windows << window
        end
      end
    end
  end
end
