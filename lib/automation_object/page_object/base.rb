# frozen_string_literal: true

module AutomationObject
  module PageObject
    module Base
      def self.included(base)
        base.extend(ClassMethods)
      end

      # Class level methods
      module ClassMethods
        attr_writer :options

        # @return [Hash]
        def options
          @options ||= {}
        end
      end
    end
  end
end
