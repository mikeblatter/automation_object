# frozen_string_literal: true
module AutomationObject
  module BluePrint
    module Composite
      # Helper module for multiple element composite classes
      module MultipleElementsHelper
        # @return [Range, nil] gives range for limiting multiple elements or nil
        def custom_range
          adapter.custom_range
        end

        # @return [Symbol, nil] gives element method to remove duplicates on or nil
        def remove_duplicates
          adapter.remove_duplicates
        end
      end
    end
  end
end
