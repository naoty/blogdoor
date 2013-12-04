require "redcarpet"

module Blogdoor
  class Converter
    def initialize
      renderer = Redcarpet::Render::HTML.new(prettify: true)
      @markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
    end

    def convert(content)
      @markdown.render(content)
    end
  end
end
