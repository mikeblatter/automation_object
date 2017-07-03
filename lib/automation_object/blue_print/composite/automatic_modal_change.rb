# frozen_string_literal: true

# Require parent class
require_relative 'base'

module AutomationObject
  module BluePrint
    module Composite
      # AutomaticModalChange composite class
      class AutomaticModalChange < Base
        # @return [Symbol, nil]
        def modal_name
          adapter.modal_name
        end

        # @return [Integer]
        def number_of_checks
          adapter.number_of_checks
        end

        # @return [Boolean]
        def close
          adapter.close
        end
      end
    end
  end
end
