# frozen_string_literal: true

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
          node['action']
        end

        def new_window?
          attribute('target') == '_blank'
        end

        # @return [Hash]
        def params
          params = {}

          node.traverse do |node|
            next unless node.name == 'input'
            params[node['name']] = node['value']
          end

          params
        end

        # @return [Symbol]
        def request_method
          node['method'].casecmp('GET').zero? ? :get : :post
        end
      end
    end
  end
end
