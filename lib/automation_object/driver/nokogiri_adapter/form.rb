module AutomationObject
  module Driver
    module NokogiriAdapter
      class Form
        # @param node [Nokogiri::XML::Node]
        def initialize(node)
          @node = node
        end

        # @return [Hash]
        def params
          params = {}

          @node.traverse {|node|
            next unless node.name == 'input'
            params[node['name']] = node['value']
          }

          return params
        end

        # @return [Symbol]
        def request_method
          (@node['method'].upcase == 'GET') ? :get : :post
        end
      end
    end
  end
end