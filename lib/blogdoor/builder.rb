require "pathname"
require "erb"
require "redcarpet"

module Blogdoor
  class Builder
    def initialize(args = {})
      @root_path = Pathname.new(args[:root_path] || ".")
      @builds_path = @root_path.join("builds")

      layout_path = Pathname.new(args[:layout_path] || "./layout.erb")
      @layout = ERB.new(layout_path.read)
      @renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true)
    end

    def build_all
      @builds_path.mkdir unless @builds_path.exist?
      Pathname.glob("#{@root_path.to_s}/**/*.md") do |post_path|
        build(post_path)
      end
    end

    def build(post_path)
      filename = post_path.basename(".md")
      html_path = @builds_path.join("#{filename}.html")

      content = @renderer.render(post_path.read)
      context = Context.new({ title: filename, created_at: post_path.mtime, content: content })
      html = @layout.result(context.to_binding)
      html_path.open("wb") { |file| file.write(html) }
    end

    class Context
      def initialize(args = {})
        @title = args[:title] || "Preview"
        @created_at = (args[:created_at] || Time.now).strftime("%Y-%m-%d")
        @content = args[:content] || ""
      end

      def to_binding
        binding
      end
    end
  end
end
