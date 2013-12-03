require "spec_helper"
require "pathname"

describe Blogdoor::Builder do
  let(:root_path) { Pathname.new("../fixtures").expand_path(File.dirname(__FILE__)) }
  let(:layout_path) { root_path.join("layout.erb") }
  let(:builds_path) { root_path.join("builds") }
  let(:builder) { described_class.new({ root_path: root_path, layout_path: layout_path }) }

  after(:each) do
    builds_path.rmtree
  end

  describe "#build_all" do
    it "makes './builds' directory" do
      builder.build_all
      expect(builds_path).to exist
    end

    it "builds HTML file under './builds' directory" do
      builder.build_all
      expect(builds_path.entries).to have_at_least(3).items
    end
  end

  describe "#build" do
    it "inserts script tags for livereload" do
      builds_path.mkdir
      builder.build(root_path.join("sample.md"))
      html = builds_path.join("sample.html").read
      expect(html).to include "jquery.js"
      expect(html).to include "livereload.js"
    end
  end
end
