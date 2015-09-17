require_relative 'composite'
require_relative '../proxies/element_group'

module AutomationObject
  module Dsl
    module BluePrintAdapter
      #ElementGroup BluePrint adapter composite
      class ElementGroup < Composite
        #Which proxy to create for this composite
        implements_proxy AutomationObject::Dsl::Proxies::ElementGroup
      end
    end
  end
end