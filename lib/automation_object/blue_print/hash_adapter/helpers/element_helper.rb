module AutomationObject::BluePrint
  module HashAdapter
    #Helper module for Element composite classes
    module ElementHelper
      # @return [Array<Symbol, String>, nil] params as an array for driver find_element args
      def selector_params
        case
          when self.hash[:xpath].is_a?(String)
            [:xpath, self.hash[:xpath]]
          when self.hash[:css].is_a?(String)
            [:css, self.hash[:css]]
          else
            nil
        end
      end

      # @return [Symbol, nil] element name of iframe element is in or nil if not
      def in_iframe
        case self.hash[:in_iframe]
          when Symbol, String
            self.hash[:in_iframe].to_sym
          else
            nil
        end
      end

      # @return [Boolean] whether or not element is in iframe
      def in_iframe?
        (self.in_iframe) ? true : false
      end
<<<<<<< HEAD
=======

      def method_hook?(name)
        return self.method_hooks.has_key?(name)
      end

      # @return [Hash<Hook>] array of Hook that are defined under the element
      def method_hooks
        return @method_hooks if @method_hooks

        children = {}
        self.hash.each { |key, value|
          #Skip possible keys that elements can have
          #Otherwise should be a method hook
          next if [:load, :custom_methods, :in_iframe, :css, :xpath, :define_elements_by, :custom_range].include?(key)
          children[key] = value
        }

        @method_hooks = self.create_hash_children(children,
                                                   { interface: Hook,
                                                     location: self.location + '[hook]' })

        return @method_hooks
      end
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
    end
  end
end

