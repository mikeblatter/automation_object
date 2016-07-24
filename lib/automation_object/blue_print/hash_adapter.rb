require_relative 'hash_adapter/top'

module AutomationObject::BluePrint
  #BluePrint Hash Adapter
  module HashAdapter
    # @param [Hash] hash that includes all the information needed to create a BluePrint
    # @return [AutomationObject::BluePrint::HashAdapter::Top] Composite BluePrint Object
    def self.build_composite(hash = {})
      hash.symbolize_keys_deep!
      Top.new(hash, :top)
    end
  end
end