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

  # ruby mutation methods have the expectation to return self if a mutation occurred, nil otherwise. (see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-gsub-21)
  def to_underscore!
    gsub!(/(.)([A-Z])/,'\1_\2')
    downcase!
  end

  def to_underscore
    dup.tap { |s| s.to_underscore! }
  end
end