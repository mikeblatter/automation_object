require_relative '../../proxies/proxy'

require_relative 'helpers/composite_helper'

module AutomationObject::Dsl
  module Proxies
    #ElementGroup proxy for model
    class ElementGroup < AutomationObject::Proxies::Proxy
      include CompositeHelper

      def initialize
        @subject = nil
      end
    end
  end
end