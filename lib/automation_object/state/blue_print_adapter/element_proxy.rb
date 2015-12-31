require_relative '../../proxies/proxy'

module AutomationObject
  module State
    module BluePrintAdapter
      #Proxy class to allow for usage of hooks
      class ElementProxy < AutomationObject::Proxies::Proxy
        def initialize(args = {})
          @composite = args.fetch :composite
          @subject = args.fetch :element
        end

        #Overiding base method to run possible hooks
        def method_missing(method_symbol, *args, &block)
          puts method_symbol
          ap @composite.blue_prints.method_hook?(method_symbol)

          return @subject.send(method_symbol, *args, &block)
        end
      end
    end
  end
end