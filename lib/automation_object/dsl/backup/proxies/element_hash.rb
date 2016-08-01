require_relative '../../proxies/proxy'

require_relative 'helpers/composite_helper'

module AutomationObject::Dsl
  module Proxies
    #ElementHash proxy for model
    class ElementHash < AutomationObject::Proxies::Proxy
      include CompositeHelper

      def initialize
        @subject = nil
      end
    end
  end
end