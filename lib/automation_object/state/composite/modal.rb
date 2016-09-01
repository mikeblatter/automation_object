require_relative '_base'

require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module State
    module Composite
      #TODO: refactor to container
      class Modal < Base
        has_one :load, interface: Hook

        has_many :elements, interface: Element
        has_many :element_arrays, interface: ElementArray
        has_many :element_hashes, interface: ElementHash

        attr_accessor :active
        # @return [Boolean] screen is active or not
        def active
          return @active ||= false
        end
      end
    end
  end
end