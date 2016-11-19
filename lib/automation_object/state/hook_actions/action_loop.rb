# frozen_string_literal: true
module AutomationObject
  module State
    # Composite action loop base class
    class ActionLoop
      # @return [AutomationObject::State::Base]
      attr_accessor :composite
      # @return [AutomationObject::Driver::Driver]
      attr_accessor :driver
      # @return [AutomationObject::BluePrint::Composite::Base]
      attr_accessor :blue_prints
      # @return [Integer]
      attr_accessor :loops

      # @param composite [AutomationObject::State::Composite::Base]
      # @param driver [AutomationObject::Driver::Driver]
      # @param blue_prints [AutomationObject::BluePrint::Composite::Base]
      # @param loops [Integer]
      def initialize(composite, driver, blue_prints, loops = 30)
        self.composite = composite
        self.driver = driver
        self.blue_prints = blue_prints
        self.loops = loops
      end

      # @return [Boolean] run success or not
      def run
        loops.times do
          # Sub classes implement single run
          return true if single_run
        end

        false
      end

      # Abstract method, override
      # @return [Boolean] success or not
      def single_run
        raise NotImplementedError
      end
    end
  end
end
