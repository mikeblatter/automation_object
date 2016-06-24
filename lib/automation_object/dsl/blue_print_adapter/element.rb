require_relative 'composite'
require_relative '../proxies/element'

module AutomationObject
  module Dsl
    module BluePrintAdapter
      #Element BluePrint adapter composite
      class Element < Composite
        #Which proxy to create for this composite
        implements_proxy AutomationObject::Dsl::Proxies::Element
      end
    end
  end
end