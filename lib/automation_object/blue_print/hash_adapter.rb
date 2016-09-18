require_relative 'composite/top'
require_relative 'hash_adapter/top'

module AutomationObject::BluePrint
  # BluePrint Hash Adapter
  module HashAdapter
    extend self
    # @param [Hash] hash that includes all the information needed to create a BluePrint
    # @return [AutomationObject::BluePrint::Composite::Top] Composite BluePrint Object
    def build(hash = {})
      hash.symbolize_keys_deep!

      top_hash = AutomationObject::BluePrint::HashAdapter::Top.new(hash)
      AutomationObject::BluePrint::Composite::Top.new(top_hash)
    end
  end
end
