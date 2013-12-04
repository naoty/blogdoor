require "thor"
require "rack"

module Blogdoor
  class Command < Thor
    desc "start", "Start blogdoor"
    option :ignore, type: :array, aliases: "-I", default: []
    def start
      builder = Builder.new(ignore_patterns: options[:ignore])
      builder.build_all
      watcher = Watcher.new
      watcher.builder = builder
      watcher.start
      Rack::Handler::Thin.run Server.new, Port: 5678
    end
  end
end
