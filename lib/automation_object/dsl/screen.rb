require_relative 'base'
require_relative 'modal'
require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module Dsl
    class Screen < Base
      # @param [AutomationObject::BluePrint::Composite::Screen] blue_prints
      # @param [AutomationObject::State::Session] state
      def initialize(blue_prints, state)
        has_many :modals, Modal
        has_many :elements, Element
        has_many :element_arrays, ElementArray
        has_many :element_hashes, ElementHash

        super(blue_prints, state, Model::Screen.new)
      end
    end
  end
end