require "sinatra"
require "sinatra-websocket"

module Blogdoor
  class Server < Sinatra::Base
    set :sockets, []

    get "/websocket" do
      if !request.websocket?
        return [400, {}, []]
      end

      request.websocket do |socket|
        socket.onopen do
          settings.sockets << socket
        end

        socket.onclose do
          settings.sockets.delete(socket)
        end

        socket.onerror do
          puts "connection error"
        end
      end
    end

    post "/" do
      EM.next_tick do
        settings.sockets.each { |socket| socket.send("") }
      end
    end
  end
end
