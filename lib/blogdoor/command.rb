require "thor"
require "rack"

module Blogdoor
  class Command < Thor
    desc "start", "Start blogdoor"
    def start
      builder = Builder.new
      builder.build_all
      watcher = Watcher.new
      watcher.builder = builder
      watcher.start
      Rack::Handler::Thin.run Server.new, Port: 5678
    end
  end
end
