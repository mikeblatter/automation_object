# frozen_string_literal: true

require_relative 'composite/top'
require_relative 'hash_adapter/top'

module AutomationObject
  module BluePrint
    # BluePrint Hash Adapter
    module HashAdapter
      module_function

      # @param [Hash] hash that includes all the information needed to create a BluePrint
      # @return [AutomationObject::BluePrint::Composite::Top] Composite BluePrint Object
      def build(hash = {})
        hash.symbolize_keys_deep!

        top_hash = self::Top.new(hash)
        AutomationObject::BluePrint::Composite::Top.new(top_hash)
      end
    end
  end
end
