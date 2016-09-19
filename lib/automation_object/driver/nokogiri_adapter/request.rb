# frozen_string_literal: true
module AutomationObject
  module Driver
    module NokogiriAdapter
      # Request class
      class Request
        attr_accessor :type, :url, :params

        def initialize(type, url, params)
          self.type = type
          self.url = url
          self.params = params
        end
      end
    end
  end
end
