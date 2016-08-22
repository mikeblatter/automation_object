require_relative '_base'
require_relative '_proxy'

require_relative 'element'
require_relative 'element_array'
require_relative 'element_hash'

module AutomationObject
  module Dsl
    class Modal < Base
      has_many :elements, ElementProxy
      has_many :element_arrays, ElementArrayProxy
      has_many :element_hashes, ElementHashProxy
    end

    class ModalProxy < Proxy
      # @param [AutomationObject::BluePrint::Composite::Modal] blue_prints
      # @param [AutomationObject::State::Session] state
      # @param [Symbol] name
      def initialize(blue_prints, state, name)
        super Modal.new(blue_prints, state, name)
      end

      # @param [Symbol] method
      # @param [Array, nil] args
      # @param [Proc] block
      def method_missing(method, *args, &block)
        #If trying to access children then load Modal
        if @subject.has_key?(method)
          @state.load(:modal, @name)
        end

        super
      end
    end
  end
end