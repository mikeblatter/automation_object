require 'securerandom'
require_relative 'error'

module AutomationObject::Driver::NokogiriAdapter
  #Class for creating/maintaining XML session
  #Trying to replicate some functionality of Selenium like multiple windows, etc...
  class Session
    attr_accessor :window_handles, :window_handle, :current_url, :url_history

    def initialize
      self.create_session
    end

    def create_session
      self.current_url = nil
      self.url_history = { self.window_handle => Array.new }
      self.window_handles = [self.window_handle]

      @windows_xml = Hash.new

      return nil
    end

    def new_window
      self.window_handles.push(SecureRandom.hex(16))
      self.url_history[self.window_handles.last] = Array.new
      self.window_handle = self.window_handles.last
    end

    # @return [String] current window handle
    def window_handle
      @window_handle ||= SecureRandom.hex(16)
    end

    #Switch window handles
    # @param handle_value [String] handle value of window to switch to
    def window_handle=(handle_value)
      unless self.window_handles.include?(handle_value)
        raise NoSuchWindowError
      end

      #Array returns nil if length is 0, so no need for if
      self.current_url = self.url_history[handle_value].last

      @window_handle = handle_value
    end

    def xml(xml = nil)
      @windows_xml[self.window_handle] = xml if xml

      unless @windows_xml[self.window_handle]
        raise NoSuchDocumentError
      end

      return @windows_xml[self.window_handle]
    end

    # Get url, will set xml to current window handle
    # @param url [String] url to get xml for
    # @return [Object] nokogiri object
    def get(url, params = {})
      request(:get, url, params)
    end

    # Post url, will set xml to current window handle
    # @param url [String] url to get xml for
    # @return [Object] nokogiri object
    def post(url, params = {})
      request(:post, url, params)
    end

    # Request url, will set xml to current window handle
    # @param url [String] url to get xml for
    # @return [Object] nokogiri object
    def request(type, url, params)
      if url.valid_url? == false and self.current_url == nil
        raise ArgumentError, "Expecting get argument url to be a valid_url?, got #{url}"
      elsif url.valid_url? == false and self.current_url
        url = self.current_url.join_url(url)
      end

      client_resource = RestClient::Resource.new(url, :ssl_version => 'SSLv23_client')
      response = client_resource.send(type)

      self.current_url = url
      self.url_history[self.window_handle].push(url)
      self.xml(Nokogiri::HTML.parse(response))
    end

    def back
      current_url_index = self.url_history[self.window_handle].index(self.current_url)
      return if current_url_index == 0

      self.url_history[self.window_handle].delete_at(current_url_index)
      url = self.url_history[self.window_handle].delete_at(current_url_index - 1) #get will insert url anyways

      self.get(url)
    end

    def close
      #Just reset everything if only one "window" is open
      return self.create_session if self.window_handles.length == 1

      @windows_xml.delete(self.window_handle)
      self.url_history.delete(self.window_handle)
      self.window_handles.delete(self.window_handle)
      self.window_handle = self.window_handles.first
    end

    #Just reset the session
    def quit
      self.create_session
    end
  end
end