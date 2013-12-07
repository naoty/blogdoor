require "redcarpet"
require "pygments"

module Blogdoor
  class Converter
    def initialize
      renderer = BlockCodeWithFilename.new
      @markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
    end

    def convert(content)
      @markdown.render(content)
    end

    class BlockCodeWithFilename < Redcarpet::Render::HTML
      INDENT = " " * 2

      def block_code(code, metadata)
        language, filename = metadata.split(":") if metadata
        rows = []
        rows << %(<div class="code-block">)
        if filename
          rows << %(#{INDENT}<div class="code-header">)
          rows << %(#{INDENT * 2}<span>#{filename}</span>)
          rows << %(#{INDENT}</div>)
        end
        rows << %(#{INDENT}<div class="code-body">)
        rows << %(#{INDENT * 2}#{Pygments.highlight(code, lexer: language)})
        rows << %(#{INDENT}</div>)
        rows << %(</div>)
        rows.join("\n")
      end
    end
  end
end
