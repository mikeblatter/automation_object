# frozen_string_literal: true

module AutomationObject
  module BluePrint
    module PageObjectAdapter
      # Top composite
      class Top
        def initialize
          ap UserDefined.constants
        end
      end
    end
  end
end
