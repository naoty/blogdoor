lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "blogdoor/version"

Gem::Specification.new do |spec|
  spec.name          = "blogdoor"
  spec.version       = Blogdoor::VERSION
  spec.authors       = ["Naoto Kaneko"]
  spec.email         = ["naoty.k@gmail.com"]
  spec.summary       = %q{Blogdoor is a toolkit for easily publishing posts from local to your blog.}
  spec.homepage      = "https://github.com/naoty/blogdoor"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "redcarpet"
  spec.add_dependency "listen"
  spec.add_dependency "sinatra"
  spec.add_dependency "sinatra-websocket"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
