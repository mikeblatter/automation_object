require_relative 'composite'
<<<<<<< HEAD
=======
require_relative 'helpers/element_helper'

require_relative 'element_proxy'
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41

module AutomationObject
  module State
    module BluePrintAdapter
      class ElementGroup < Composite
<<<<<<< HEAD
=======
        include ElementHelper
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41

      end
    end
  end
end