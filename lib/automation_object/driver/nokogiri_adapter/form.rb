module AutomationObject
  module Driver
    module NokogiriAdapter
      # Class to wrap a form node
      class Form
        # @return [Nokogiri::XML::Node]
        attr_accessor :node

        # @param node [Nokogiri::XML::Node]
        def initialize(node)
          self.node = node
        end

        def url
          self.node['action']
        end

        def new_window?
          self.attribute('target') == '_blank'
        end

        # @return [Hash]
        def params
          params = {}

          self.node.traverse { |node|
            next unless node.name == 'input'
            params[node['name']] = node['value']
          }

          return params
        end

        # @return [Symbol]
        def request_method
          (self.node['method'].upcase == 'GET') ? :get : :post
        end
      end
    end
  end
end
