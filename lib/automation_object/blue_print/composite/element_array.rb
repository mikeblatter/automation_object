# Require parent class
require_relative 'base'

require_relative 'hook'

require_relative 'helpers/element_helper'
require_relative 'helpers/multiple_elements_helper'

module AutomationObject
  module BluePrint
    module Composite
      # ElementArray composite class, passing method to adapter only
      # Hoping to improve code completion and standard interface where
      # classes use this as a template to add additional adapters
      class ElementArray < Base
        include ElementHelper
        include MultipleElementsHelper
      end
    end
  end
end
