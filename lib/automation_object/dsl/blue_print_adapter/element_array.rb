require_relative 'composite'
require_relative '../proxies/element_array'

module AutomationObject
  module Dsl
    module BluePrintAdapter
      #ElementArray BluePrint adapter composite
      class ElementArray < Composite
        #Which proxy to create for this composite
        implements_proxy AutomationObject::Dsl::Proxies::ElementArray
      end
    end
  end
end