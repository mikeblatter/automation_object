require_relative '../../proxies/proxy'
<<<<<<< HEAD
require_relative '../models/element_hash'

require_relative 'helpers/composite_helper'
=======

require_relative 'helpers/composite_helper'

>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
module AutomationObject::Dsl
  module Proxies
    #ElementHash proxy for model
    class ElementHash < AutomationObject::Proxies::Proxy
      include CompositeHelper

      def initialize
<<<<<<< HEAD
        @subject = Models::ElementHash.new
=======
        @subject = nil
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
      end
    end
  end
end