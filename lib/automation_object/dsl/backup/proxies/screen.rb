require_relative '../../proxies/proxy'
require_relative '../models.rb'

require_relative 'helpers/composite_helper'

module AutomationObject::Dsl
  module Proxies
    #Screen proxy for model
    class Screen < AutomationObject::Proxies::Proxy
      include CompositeHelper

      def initialize
        @subject = Models::Screen.new
      end
    end
  end
end