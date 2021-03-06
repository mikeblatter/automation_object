# frozen_string_literal: true

require_relative 'error'
require_relative 'window'

module AutomationObject
  module Driver
    module NokogiriAdapter
      # Class for creating/maintaining XML session
      # Trying to replicate some functionality of Selenium like multiple windows, etc...
      class Session
        def initialize
          @windows = [Window.new]
          @position = 0 # Position
        end

        def xml
          return nil if @windows[@position].nil?

          @windows[@position].xml
        end

        # @return [Array<String>] window handles
        def window_handles
          @windows.map(&:handle)
        end

        # @return [String] current window handle
        def window_handle
          return nil if @windows[@position].nil?

          @windows[@position].handle
        end

        # @return [String] current URL
        def current_url
          return nil if @windows[@position].nil?

          @windows[@position].current_url
        end

        # Switch window handles
        # @param handle_value [String] handle value of window to switch to
        def window_handle=(handle_value)
          raise NoSuchWindowError unless window_handles.include?(handle_value)

          @position = 0
          @windows.each_with_index do |index, window|
            @position = index if window.handle == handle_value
          end
        end

        # Request url, will set xml to current window handle
        # @param type [Symbol] request type
        # @param url [String] url
        # @param params [Hash<String:String>] params
        # @param blank [Boolean] new window
        # @return [void]
        def request(type, url, params = {}, blank = false)
          if blank
            @windows.push(Window.new)
            @position = @windows.length - 1
          end

          @windows[@position].request(type, url, params)
        end

        def back
          return if @windows[@position].nil?

          @windows[@position].back
        end

        def forward
          return if @windows[@position].nil?

          @windows[@position].forward
        end

        def refresh
          return if @windows[@position].nil?

          @windows[@position].refresh
        end

        def close
          # Reset session if only one window
          quit if @windows.length == 1

          @windows.delete_at(@position)
          @position -= 1 if @position.positive?
        end

        # Just reset the session
        def quit
          @windows = [Window.new]
        end
      end
    end
  end
end
