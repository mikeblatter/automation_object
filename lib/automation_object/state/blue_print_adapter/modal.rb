require_relative 'composite'

require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module State
    module BluePrintAdapter
      #Operates similarly to screen
      class Modal < Screen
      end
    end
  end
end