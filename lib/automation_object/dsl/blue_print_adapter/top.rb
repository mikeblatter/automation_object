require_relative 'composite'
require_relative '../proxies/top'

require_relative 'screen'

module AutomationObject
  module Dsl
    module BluePrintAdapter
      #Top BluePrint adapter composite
      class Top < Composite
        #Which proxy to create for this composite
        implements_proxy AutomationObject::Dsl::Proxies::Top

        #Children for this composite
        has_many :screens, interface: Screen
      end
    end
  end
end