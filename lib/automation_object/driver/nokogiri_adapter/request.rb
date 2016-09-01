module AutomationObject
  module Driver
    module NokogiriAdapter
      class Request
        attr_accessor :type, :url, :params

        def initialize(type, url, params)
          self.type, self.url, self.params = type, url, params
        end
      end
    end
  end
end