require_relative 'base'
require_relative 'element'

module AutomationObject
  module Driver
    Point     = Struct.new(:x, :y)
    Dimension = Struct.new(:width, :height)
    BoxCoordinates = Struct.new(:x1, :y1, :x2, :y2)

    #Driver adapter interface
    #Adapters should meet this interface standard
    class Driver < Base
      # Navigates current window to a given url
      # @param url [String] navigate to the following url
      # @return [void]
      def get(url)
        self.adapter.get(url)
      end

      # Set timeout wait
      # @param timeout [Integer] the timeout in seconds
      # @return [void]
      def set_wait(timeout = nil)
        self.adapter.set_wait(timeout)
      end

      # @param selector_type [Symbol] selector type (:css, :xpath, etc...)
      # @param selector_path [String] path to element
      # @return [Boolean] exists or not
      def exists?(selector_type, selector_path)
        self.adapter.exists?(selector_type, selector_path)
      end

      # @param selector_type [Symbol] selector type, :css, :xpath, etc...
      # @param selector_path [String] path to element
      # @return [AutomationObject::Driver::Element] element
      def find_element(selector_type, selector_path)
        self.adapter.find_element(selector_type, selector_path)
      end

      # @param selector_type [Symbol] selector type, :css, :xpath, etc...
      # @param selector_path [String] path to element
      # @return [Array<AutomationObject::Driver::Element>] elements
      def find_elements(selector_type, selector_path)
        self.adapter.find_elements(selector_type, selector_path)
      end

      #Accept prompt either in browser or mobile
      def accept_prompt
        self.adapter.accept_prompt
      end

      #Dismiss the prompt
      def dismiss_prompt
        self.adapter.dismiss_prompt
      end

      # Check if browser, more useful for Appium but can be generic here
      # @return [Boolean] whether or not browser is being used
      def is_browser?
        self.adapter.is_browser?
      end

      #Window Handles
      # @return [Array<String>] array of window handle ids
      def window_handles
        self.adapter.window_handles
      end

      #Current window handle
      # @return [String] handle id
      def window_handle
        self.adapter.window_handle
      end

      #Set current window handle to, will switch windows
      # @param handle_value [String] window handle value
      def window_handle=(handle_value)
        self.adapter.window_handle(handle_value)
      end

      # Run script in browser to check if document in JS is complete
      # @return [Boolean] document is complete
      def document_complete?
        self.adapter.document_complete?
      end

      # Wait till the document is complete
      # @return [void]
      def document_complete_wait
        self.adapter.document_complete_wait
      end

      # @param script [String] JS to run
      # @return [Object, nil]
      def execute_script(script)
        self.adapter.execute_script(script)
      end

      # Destroy the driver
      def quit
        self.adapter.quit
      end
    end
  end
end