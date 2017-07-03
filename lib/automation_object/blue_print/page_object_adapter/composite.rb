# frozen_string_literal: true

require_relative '../../helpers/composite'
require_relative '../../helpers/string'

module AutomationObject
  module BluePrint
    module PageObjectAdapter
      # Base composite for PageObject adapter
      class Composite < AutomationObject::Composite
        attr_accessor :constant

        # @param constant [Class] class to build composite off of
        # @param name [Symbol] name of composite element
        # @param parent [Object, nil] parent composite object
        # @param location [String] string location for error/debugging purposes
        def initialize(constant = nil, name = :top, parent = nil, location = 'top')
          self.constant = constant.is_a?(Class) ? constant : nil
          super(name, parent, location)
        end
      end
    end
  end
end
