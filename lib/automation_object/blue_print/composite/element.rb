#Require parent class
require_relative 'base'

require_relative 'hook'
require_relative 'custom_method'

require_relative 'helpers/element_helper'

module AutomationObject
  module BluePrint
    module Composite
      #Element composite class, passing method to adapter only
      #Hoping to improve code completion and standard interface where
      #classes use this as a template to add additional adapters
      class Element < Base
        include ElementHelper
      end
    end
  end
end