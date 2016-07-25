#Run rails app everytime and clean up
require 'rest-client'

class RailsApp
  PORT = 3024
  HOST = "http://localhost:#{PORT}"
  BASE_DIR = File.expand_path(File.join(File.dirname(__FILE__), 'example_rails_app/'))

  def initialize
    at_exit {
      self.destroy
    }
  end

  def create
    `cd #{BASE_DIR}; bundle install`
    @pid = Process.spawn("cd #{BASE_DIR}; rails s -p #{PORT} > /dev/null 2>&1")#

    10.times do
      sleep(5)

      begin
        RestClient.get(HOST)
        return
      rescue Exception => e
      end
    end

    raise 'Could not create server'
  end

  def destroy
    return unless @pid

    begin
      `kill $(lsof -t -i:3000)`
      puts 'Killed all processes'
      @pid = nil
    rescue Exception => e
    end
  end
end
