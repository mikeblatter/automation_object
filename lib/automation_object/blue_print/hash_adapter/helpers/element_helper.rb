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
    end
  end
end

