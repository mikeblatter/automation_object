# frozen_string_literal: true

require_relative 'composite'

require_relative 'helpers/element_helper'
require_relative 'helpers/multiple_elements_helper'

module AutomationObject
  module BluePrint
    module PageObjectAdapter
      # ElementHash composite
      class ElementHash < Composite
        include ElementHelper
        include MultipleElementsHelper

        # @return [Symbol, nil] element method to define element keys by
        def define_elements_by
          return nil unless get_property(:define_elements_by)

          get_property(:define_elements_by).to_sym
        end
      end
    end
  end
end
