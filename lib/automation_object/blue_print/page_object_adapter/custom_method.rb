# frozen_string_literal: true

require_relative 'composite'

module AutomationObject
  module BluePrint
    module PageObjectAdapter
      # CustomMethod composite
      class CustomMethod < Composite
        def element_method
          element_method = get_property(:element_method)

          case element_method
          when Symbol, String
            return element_method.to_sym
          else
            return nil
          end
        end

        def evaluate
          get_property(:evaluate) || nil
        end
      end
    end
  end
end
