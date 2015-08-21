require_relative 'composite'
require_relative '../proxies/screen'

require_relative 'modal'
require_relative 'element'
require_relative 'element_array'
require_relative 'element_group'
require_relative 'element_hash'

module AutomationObject
  module Dsl
    module BluePrintAdapter
      #Screen BluePrint adapter composite
      class Screen < Composite
        #Which proxy to create for this composite
        implements_proxy AutomationObject::Dsl::Proxies::Screen

        #Children for this composite
        has_many :modals, interface: Modal

        has_many :elements, interface: Element
        has_many :element_arrays, interface: ElementArray
        has_many :element_groups, interface: ElementGroup
        has_many :element_hashes, interface: ElementHash
      end
    end
  end
end