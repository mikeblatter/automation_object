require_relative '../../proxies/proxy'

require_relative 'helpers/composite_helper'

module AutomationObject::Dsl
  module Proxies
    #ElementArray proxy for model
    class ElementArray < AutomationObject::Proxies::Proxy
      include CompositeHelper

      def initialize
        @subject = nil
      end
    end
  end
end