# frozen_string_literal: true
# Require parent class
require_relative 'base'

require_relative 'hook'

require_relative 'helpers/element_helper'
require_relative 'helpers/multiple_elements_helper'

module AutomationObject
  module BluePrint
    module Composite
      # ElementHash composite class
      class ElementHash < Base
        include ElementHelper
        include MultipleElementsHelper

        # @return [Symbol] element method to define element keys by
        def define_elements_by
          adapter.define_elements_by
        end
      end
    end
  end
end
