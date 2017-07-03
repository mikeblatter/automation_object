# frozen_string_literal: true
module AutomationObject
  module BluePrint
    module Composite
      # Helper module for Element composite classes
      module ElementHelper
        # @return [String, nil] text input for automatic screen/modal change if needed
        def default_input
          adapter.default_input
        end

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

        # @return [Hash<AutomationObject::BluePrint::Composite::Hook>] hash of Hook that are defined under the element
        def method_hooks
          adapter.method_hooks
        end

        # Get possible changes
        # @return [Array<Symbol>]
        def changes
          changes = []
          self.method_hooks.each_value { |hook|
            changes += hook.changes
          }

          changes.uniq.compact
        end

        # @param name [Symbol] name of container you want to go to
        # @return [Symbol] method name
        def method_to_container(name)
          self.method_hooks.each { |method_name, hook|
            next unless hook.changes.include?(name)

            return method_name
          }

          nil
        end
      end
    end
  end
end
