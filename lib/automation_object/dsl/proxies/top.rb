require_relative '../../proxies/proxy'
require_relative '../models'

require_relative 'helpers/composite_helper'

module AutomationObject::Dsl
  module Proxies
    #Top proxy for model
    class Top < AutomationObject::Proxies::Proxy
      include CompositeHelper

      def initialize
        @subject = Models::Top.new
      end
    end
  end
end