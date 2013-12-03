require "listen"
require "pathname"
require "forwardable"

module Blogdoor
  class Watcher
    extend Forwardable

    attr_accessor :builder
    delegate build: :builder

    def initialize(args = {})
      @root_path = Pathname.new(args[:root_path] || ".")
    end

    def start
      listener = Listen.to(@root_path.to_s, only: /\.md$/) do |modified, added|
        [modified, added].flatten.each do |file_path|
          build(Pathname.new(file_path))
        end
      end
      trap(:INT) { listener.stop }
      listener.start
    end
  end
end
