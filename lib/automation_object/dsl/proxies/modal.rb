require_relative '../../proxies/proxy'
<<<<<<< HEAD
require_relative '../models/modal'
=======
require_relative '../models.rb'
>>>>>>> c986db7e1e052faa3fbf7f9f821e69c56b46fd41

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