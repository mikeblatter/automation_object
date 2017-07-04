# frozen_string_literal: true

require_relative 'composite'

require_relative 'helpers/element_helper'
require_relative 'helpers/multiple_elements_helper'

module AutomationObject
  module BluePrint
    module PageObjectAdapter
      # ElementArray composite
      class ElementArray < Composite
        include ElementHelper
        include MultipleElementsHelper
      end
    end
  end
end
