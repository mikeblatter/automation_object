require_relative '../../proxies/proxy'
require_relative '../models/element_array'

require_relative 'helpers/composite_helper'

module AutomationObject::Dsl
  module Proxies
    #ElementArray proxy for model
    class ElementArray < AutomationObject::Proxies::Proxy
      include CompositeHelper

      def initialize
        @subject = Models::ElementArray.new
      end
    end
  end
end