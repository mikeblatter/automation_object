require_relative '../../proxies/proxy'

module AutomationObject
  module State
    module BluePrintAdapter
      #Proxy class to allow for usage of hooks
      class ElementProxy < AutomationObject::Proxies::Proxy
        def initialize(args = {})
          @subject = args.fetch :subject
          @blue_prints = args.fetch :blue_prints
        end

        #Overiding base method to run possible hooks
        def method_missing(method_symbol, *args, &block)
          return @subject.send(method_symbol, *args, &block)
        end
      end
    end
  end
end