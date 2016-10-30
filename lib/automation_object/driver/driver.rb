# frozen_string_literal: true
require_relative 'base'
require_relative 'element'

module AutomationObject
  module Driver
    Point     = Struct.new(:x, :y)
    Dimension = Struct.new(:width, :height)
    BoxCoordinates = Struct.new(:x1, :y1, :x2, :y2)

    # Driver adapter interface
    # Adapters should meet this interface standard
    class Driver < Base
      # Navigates current window to a given url
      # @param url [String] navigate to the following url
      # @return [void]
      def get(url)
        adapter.get(url)
      end

      # Get the title of the document
      # @return [String]
      def title
        adapter.title
      end

      # Refreshes current window
      # @return [void]
      def refresh
        adapter.refresh
      end

      # Go forward
      # @return [void]
      def forward
        adapter.forward
      end

      # Go back
      # @return [void]
      def back
        adapter.back
      end

      # Set timeout wait
      # @param timeout [Integer] the timeout in seconds
      # @return [void]
      def wait(timeout = nil)
        adapter.wait(timeout)
      end

      # @param selector_type [Symbol] selector type (:css, :xpath, etc...)
      # @param selector_path [String] path to element
      # @return [Boolean] exists or not
      def exists?(selector_type, selector_path)
        adapter.exists?(selector_type, selector_path)
      end

      # @param selector_type [Symbol] selector type, :css, :xpath, etc...
      # @param selector_path [String] path to element
      # @return [AutomationObject::Driver::Element] element
      def find_element(selector_type, selector_path)
        adapter.find_element(selector_type, selector_path)
      end

      # @param selector_type [Symbol] selector type, :css, :xpath, etc...
      # @param selector_path [String] path to element
      # @return [Array<AutomationObject::Driver::Element>] elements
      def find_elements(selector_type, selector_path)
        adapter.find_elements(selector_type, selector_path)
      end

      # Accept prompt either in browser or mobile
      def accept_prompt
        adapter.accept_prompt
      end

      # Dismiss the prompt
      def dismiss_prompt
        adapter.dismiss_prompt
      end

      # Check if browser, more useful for Appium but can be generic here
      # @return [Boolean] whether or not browser is being used
      def browser?
        adapter.browser?
      end

      # Window Handles
      # @return [Array<String>] array of window handle ids
      def window_handles
        adapter.window_handles
      end

      # Current window handle
      # @return [String] handle id
      def window_handle
        adapter.window_handle
      end

      # Set current window handle to, will switch windows
      # @param handle_value [String] window handle value
      def window_handle=(handle_value)
        adapter.window_handle(handle_value)
      end

      # Run script in browser to check if document in JS is complete
      # @return [Boolean] document is complete
      def document_complete?
        adapter.document_complete?
      end

      # @param script [String] JS to run
      # @return [Object, nil]
      def execute_script(script)
        adapter.execute_script(script)
      end

      # @return [Point] x,y scroll position
      def scroll_position
        adapter.scroll_position
      end

      # @return [Float] inner window height
      def inner_window_height
        adapter.inner_window_height
      end

      # Destroy the driver
      def quit
        adapter.quit
      end
    end
  end
end
