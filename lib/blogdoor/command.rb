require "thor"

module Blogdoor
  class Command < Thor
    desc "start", "Start blogdoor"
    def start
      builder = Builder.new
      builder.build_all
      watcher = Watcher.new
      watcher.builder = builder
      watcher.start
      sleep
    end
  end
end
