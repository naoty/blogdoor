require "pathname"
require "erb"
require "redcarpet"

module Blogdoor
  class Builder
    attr_accessor :ignore_patterns

    def initialize(args = {})
      @root_path = Pathname.new(args[:root_path] || ".")
      @builds_path = @root_path.join("builds")

      layout_path = Pathname.new(args[:layout_path] || "./layout.erb")
      @layout = ERB.new(layout_path.read)
      @converter = Converter.new
      @client = Client.new

      @ignore_patterns = (args[:ignore_patterns] || []).map { |pattern| /#{pattern}/ }
    end

    def build_all
      @builds_path.mkdir unless @builds_path.exist?
      Pathname.glob("#{@root_path.to_s}/**/*.md") do |post_path|
        build(post_path)
      end
    end

    def build(post_path)
      return if @ignore_patterns.any? { |pattern| post_path.to_s =~ pattern }

      filename = post_path.basename(".md")
      html_path = @builds_path.join("#{filename}.html")

      content = @converter.convert(post_path.read)
      context = Context.new({ title: filename, created_at: post_path.mtime, content: content })
      html = @layout.result(context.to_binding)
      html = insert_script_tags(html)
      html_path.open("wb") { |file| file.write(html) }
      @client.notify
    end

    def insert_script_tags(html)
      javascripts_path = Pathname.new("../javascripts").expand_path(File.dirname(__FILE__))
      script_tags = []
      script_tags << %(<script src="#{javascripts_path.join("livereload.js")}"></script>)
      html.gsub(/<\/head>/) { "#{script_tags.join("\n")}\n</head>"}
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
