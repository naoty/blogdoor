require "spec_helper"
require "pathname"

describe Blogdoor::Converter do
  let(:converter) { described_class.new }
  let(:sample_path) { Pathname.new("../fixtures/sample.md").expand_path(File.dirname(__FILE__)) }

  describe "#convert" do
    it "generates highlighted code blocks" do
      content = converter.convert(sample_path.read)
      expect(content).to match /<div class="highlight">/
    end

    it "generates code blocks" do
      content = converter.convert(sample_path.read)
      expect(content).to match /<div class="code-block">/
      expect(content).to match /<div class="code-header">/
      expect(content).to match /<div class="code-body">/
    end
  end
end
