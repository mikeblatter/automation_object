require_relative '../../proxies/proxy'
require_relative '../models/element_hash'

require_relative 'helpers/composite_helper'
module AutomationObject::Dsl
  module Proxies
    #ElementHash proxy for model
    class ElementHash < AutomationObject::Proxies::Proxy
      include CompositeHelper

      def initialize
        @subject = Models::ElementHash.new
      end
    end
  end
end