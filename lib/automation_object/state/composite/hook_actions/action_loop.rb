# frozen_string_literal: true
module AutomationObject
  module State
    module Composite
      # Composite action loop base class
      class ActionLoop
        # @return [AutomationObject::Driver::Driver]
        attr_accessor :driver
        # @return [AutomationObject::BluePrint::Composite::Base]
        attr_accessor :blue_prints
        # @return [AutomationObject::State::Session]
        attr_accessor :session
        # @return [Integer]
        attr_accessor :loops

        # @param session [AutomationObject::State::Session]
        # @param driver [AutomationObject::Driver::Driver]
        # @param blue_prints [AutomationObject::BluePrint::Composite::Base]
        # @param loops [Integer]
        def initialize(session, driver, blue_prints, loops = 30)
          self.session = session
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
end
