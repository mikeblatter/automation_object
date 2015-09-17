require_relative 'composite'
require_relative '../proxies/element_hash'

module AutomationObject
  module Dsl
    module BluePrintAdapter
      #ElementHash BluePrint adapter composite
      class ElementHash < Composite
        #Which proxy to create for this composite
        implements_proxy AutomationObject::Dsl::Proxies::ElementHash
      end
    end
  end
end