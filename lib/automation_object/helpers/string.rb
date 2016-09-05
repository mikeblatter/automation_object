#String class method additions
class ::String
  def valid_url?
    uri = URI.parse(self)
    if uri.kind_of?(URI::HTTP)
      if self.match(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix)
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
    full_url = self.chomp('/') + url.reverse.chomp('/').reverse
    return full_url
  end

  def pascalize
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    self.split('_').map { |part| part.capitalize }.join
  end

  # Convert string to underscore
  # @return [String] underscored self string
  def to_underscore!
    gsub!(/(.)([A-Z])/,'\1_\2')
    downcase!
  end

  # Convert string to underscore
  # @return [String] underscored string
  def to_underscore
    dup.tap { |s| s.to_underscore! }
  end
end