require_relative '../../proxies/proxy'
require_relative '../models/element'

require_relative 'helpers/composite_helper'

module AutomationObject::Dsl
  module Proxies
    #Element proxy for model
    class Element < AutomationObject::Proxies::Proxy
      include CompositeHelper

      def initialize
        @subject = Models::Element.new
      end
    end
  end
end