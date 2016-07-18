require 'form'

module AutomationObject::Driver::NokogiriAdapter
  #Element class for Nokogiri/XML
  class Element < AutomationObject::Proxies::Proxy
    def initialize(args)
      @driver = args.fetch :driver
      @subject = args.fetch :element
    end

    # @return [String] id of element
    def id
      @subject['id']
    end

    # @return [String] href of element
    def href
      @subject['href']
    end

    # @return [String] text of element
    def text
      @subject['content']
    end

    # @return [String] content of element
    def content
      @subject['content']
    end

    def attribute(key, value = nil)
      @subject[key] = value if value
      return @subject[key]
    end

    def click
      url = self.href
      if self.attribute('target') == '_blank'
        @driver.new_window
      end

      @driver.get(url)
    end

    def send_keys(text)
      @subject['value'] = text
    end

    def submit
      form = find_form(@subject)
      raise 'Unable to find form' unless form_element

      @driver.send(form.request_method, form.params)
    end

    private

    # @return [AutomationObject::Driver:NokogiriAdapter::Form]
    def find_form(element)
      return nil unless element

      return AutomationObject::Driver::NokogiriAdapter::Form.new(element) if element.name == 'form'
      return find_form(element.parent)
    end
  end
end