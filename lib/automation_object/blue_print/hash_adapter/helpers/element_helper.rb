# frozen_string_literal: true

module AutomationObject
  module BluePrint
    module HashAdapter
      # Helper module for Element composite classes
      module ElementHelper
        # @return [String, nil] text input for automatic screen/modal change if needed
        def default_input
          hash[:default_input]
        end

        # @return [Array<Symbol, String>, nil] params as an array for driver find_element args
        def selector_params
          if hash[:xpath].is_a?(String)
            [:xpath, hash[:xpath]]
          elsif hash[:css].is_a?(String)
            [:css, hash[:css]]
          end
        end

        # @return [Symbol, nil] element name of iframe element is in or nil if not
        def in_iframe
          case hash[:in_iframe]
          when Symbol, String
            hash[:in_iframe].to_sym
          end
        end

        # @return [Boolean] whether or not element is in iframe
        def in_iframe?
          in_iframe ? true : false
        end

        def method_hook?(name)
          method_hooks.key?(name)
        end

        # @return [Hash<Hook>] hash of Hook that are defined under the element
        def method_hooks
          return @method_hooks if defined? @method_hooks

          children = {}
          hash.each do |key, value|
            # Skip possible keys that elements can have
            # Otherwise should be a method hook
            next if %i[load custom_methods in_iframe css xpath define_elements_by custom_range].include?(key)

            children[key] = value
          end

          @method_hooks = create_hash_children(children,
                                               interface: Hook,
                                               location: location + '[hook]')

          @method_hooks
        end
      end
    end
  end
end
