# frozen_string_literal: true

require_relative 'composite'

module AutomationObject
  module BluePrint
    module PageObjectAdapter
      # Modal composite
      class AutomaticModalChange < Composite
        # @return [Symbol, nil]
        def modal_name
          modal_name = get_property(:modal_name)

          case modal_name
            when Symbol, String
              return modal_name.to_sym
            else
              return nil
          end
        end

        # @return [Integer]
        def number_of_checks
          get_property(:number_of_checks) || 1
        end

        # @return [Boolean]
        def close
          get_property(:close) || false
        end
      end
    end
  end
end
