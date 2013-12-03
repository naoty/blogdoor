lib = File.expand_path("../lib", File.dirname(__FILE__))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "blogdoor"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end
