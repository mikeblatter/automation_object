require_relative '../../proxies/proxy'
require_relative '../models/element_group'

require_relative 'helpers/composite_helper'

module AutomationObject::Dsl
  module Proxies
    #ElementGroup proxy for model
    class ElementGroup < AutomationObject::Proxies::Proxy
      include CompositeHelper

      def initialize
        @subject = Models::ElementGroup.new
      end
    end
  end
end