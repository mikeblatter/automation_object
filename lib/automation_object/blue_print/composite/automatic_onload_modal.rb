# Require parent class
require_relative 'base'

module AutomationObject
  module BluePrint
    module Composite
      # AutomaticOnloadModal composite class, passing method to adapter only
      # Hoping to improve code completion and standard interface where
      # classes use this as a template to add additional adapters
      class AutomaticOnloadModal < Base
        # @return [Symbol, nil]
        def modal_name
          self.adapter.modal_name
        end

        # @return [Integer]
        def number_of_checks
          self.adapter.number_of_checks
        end

        # @return [Boolean]
        def close
          self.adapter.close
        end
      end
    end
  end
end
