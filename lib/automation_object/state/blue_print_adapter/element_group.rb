require_relative 'composite'
require_relative 'helpers/element_helper'

require_relative 'element_proxy'

module AutomationObject
  module State
    module BluePrintAdapter
      class ElementGroup < Composite
        include ElementHelper

      end
    end
  end
end