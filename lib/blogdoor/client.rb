require "net/http"

module Blogdoor
  class Client
    def notify
      begin
        client = Net::HTTP.new("localhost", 5678)
        client.post("/", "")
      rescue
      end
    end
  end
end
