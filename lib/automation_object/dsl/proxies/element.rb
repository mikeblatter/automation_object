require_relative '../../proxies/proxy'
<<<<<<< HEAD
require_relative '../models/element'
=======
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41

require_relative 'helpers/composite_helper'

module AutomationObject::Dsl
  module Proxies
    #Element proxy for model
    class Element < AutomationObject::Proxies::Proxy
      include CompositeHelper

      def initialize
<<<<<<< HEAD
        @subject = Models::Element.new
=======
        @subject = nil
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41
      end
    end
  end
end