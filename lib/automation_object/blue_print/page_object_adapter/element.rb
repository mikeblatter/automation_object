# frozen_string_literal: true

require_relative 'composite'

require_relative 'helpers/element_helper'

module AutomationObject
  module BluePrint
    module PageObjectAdapter
      # Element composite
      class Element < Composite
        include ElementHelper
      end
    end
  end
end
