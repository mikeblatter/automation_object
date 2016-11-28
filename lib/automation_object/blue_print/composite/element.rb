# frozen_string_literal: true
# Require parent class
require_relative 'base'

require_relative 'hook'
require_relative 'custom_method'

require_relative 'helpers/element_helper'

module AutomationObject
  module BluePrint
    module Composite
      # Element composite class
      class Element < Base
        include ElementHelper
      end
    end
  end
end
