require_relative '../../proxies/proxy'
require_relative '../models/modal'

require_relative 'helpers/composite_helper'

module AutomationObject::Dsl
  module Proxies
    #Modal proxy for model
    class Modal < AutomationObject::Proxies::Proxy
      include CompositeHelper

      def initialize
        @subject = Models::Modal.new
      end
    end
  end
end