require "net/http"

module Blogdoor
  class Client
    def send(content)
      begin
        client = Net::HTTP.new("localhost", 5678)
        client.post("/", "content=#{content}")
      rescue
      end
    end
  end
end
