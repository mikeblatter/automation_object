#Run rails app everytime and clean up
require 'rest-client'

class RailsApp
  PORT = 3024
  HOST = "http://localhost:#{PORT}"
  BASE_DIR = File.expand_path(File.join(File.dirname(__FILE__), 'rails_app/'))

  def initialize
    self.create

    at_exit {
      begin
        self.destroy
      rescue Exception => e
        ap e
      end

    }
  end

  def create
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
