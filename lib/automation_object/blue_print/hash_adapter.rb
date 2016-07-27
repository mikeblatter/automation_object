require_relative 'composite/top'
require_relative 'hash_adapter/top'

module AutomationObject::BluePrint
  #BluePrint Hash Adapter
  module HashAdapter
    extend self
    # @param [Hash] hash that includes all the information needed to create a BluePrint
    # @return [AutomationObject::BluePrint::Composite::Top] Composite BluePrint Object
    def build(hash = {})
      hash.symbolize_keys_deep!
      AutomationObject::BluePrint::Composite::Top.new(AutomationObject::BluePrint::HashAdapter, hash)
    end
  end
end