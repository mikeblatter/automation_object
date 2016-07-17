require_relative '../../proxies/proxy'
<<<<<<< HEAD
require_relative '../models/top'
=======
require_relative '../models'
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41

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