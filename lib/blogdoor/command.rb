require "thor"

module Blogdoor
  class Command < Thor
    desc "start", "Start blogdoor"
    def start
      builder = Builder.new
      builder.build_all
    end
  end
end
