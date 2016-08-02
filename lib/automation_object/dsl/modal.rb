require_relative 'base'
require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module Dsl
    class Modal < Base
      # @param [AutomationObject::BluePrint::Composite::Modal] blue_prints
      # @param [AutomationObject::State::Session] state
      def initialize(blue_prints, state)
        has_many :elements, Element
        has_many :element_arrays, ElementArray
        has_many :element_hashes, ElementHash

        super(blue_prints, state, Model::Modal.new)
      end
    end
  end
end