# frozen_string_literal: true
# String class method additions
class String
  def valid_url?
    uri = URI.parse(self)
    if uri.is_a?(URI::HTTP)
      if self =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
        return true
      else
        return false
      end
    else
      return false
    end
  rescue URI::InvalidURIError
    return false
  end

  def join_url(url)
    full_url = chomp('/') + url.reverse.chomp('/').reverse
    full_url
  end

  def pascalize
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    split('_').map(&:capitalize).join
  end

  # Convert string to underscore
  # @return [String] underscored self string
  def to_underscore!
    gsub!(/(.)([A-Z])/, '\1_\2')
    downcase!
  end

  # Convert string to underscore
  # @return [String] underscored string
  def to_underscore
    dup.tap(&:to_underscore!)
  end
end
