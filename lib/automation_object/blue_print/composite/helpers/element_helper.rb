module AutomationObject
  module BluePrint
    module Composite
      # Helper module for Element composite classes
      module ElementHelper
        # @return [Array<Symbol, String>, nil] params as an array for driver find_element args
        def selector_params
          adapter.selector_params
        end

        # @return [Symbol, nil] element name of iframe element is in or nil if not
        def in_iframe
          adapter.in_iframe
        end

        # @return [Boolean] whether or not element is in iframe
        def in_iframe?
          adapter.in_iframe?
        end

        def method_hook?(name)
          adapter.method_hook?(name)
        end

        # @return [Hash<Hook>] array of Hook that are defined under the element
        def method_hooks
          adapter.method_hooks
        end
      end
    end
  end
end
