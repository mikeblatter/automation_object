# frozen_string_literal: true
# Hash class method additions
class Hash
  def deep_merge(second)
    merger = proc { |_key, v1, v2| v1.is_a?(Hash) && v2.is_a?(Hash) ? v1.merge(v2, &merger) : v2 }
    merge(second, &merger)
  end

  def symbolize_keys_deep!(h = self)
    h.keys.each do |k|
      ks = k.respond_to?(:to_sym) ? k.to_sym : k
      h[ks] = h.delete k # Preserve order even when k == ks
      symbolize_keys_deep! h[ks] if h[ks].is_a?(Hash)
    end
  end
end
