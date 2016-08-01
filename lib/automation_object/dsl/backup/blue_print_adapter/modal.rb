require_relative 'composite'
require_relative '../proxies/modal'

require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module Dsl
    module BluePrintAdapter
      #Modal BluePrint adapter composite
      class Modal < Composite
        #Which proxy to create for this composite
        implements_proxy AutomationObject::Dsl::Proxies::Modal

        #Children for this composite
        has_many :elements, interface: Element
        has_many :element_arrays, interface: ElementArray
        has_many :element_hashes, interface: ElementHash
      end
    end
  end
end