# frozen_string_literal: true

require_relative 'base'

module AutomationObject
  module PageObject
    class Screen
      include AutomationObject::PageObject::Base

      class << self; end
    end
  end
end
