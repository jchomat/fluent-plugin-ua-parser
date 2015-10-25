# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-ua-parser"
  spec.version       = "0.3.0"
  spec.authors       = ["Yuri Umezaki"]
  spec.email         = ["bungoume@gmail.com"]
  spec.homepage      = "https://github.com/bungoume/fluent-plugin-ua-parser"
  spec.summary       = "Fluentd filter plugin to parse user-agent"
  spec.description   = spec.summary
  spec.license       = "APLv2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "fluentd", ">= 0.12"
  spec.add_runtime_dependency "user_agent_parser", ">= 2.2.0"
  spec.add_runtime_dependency "lru_redux", ">= 1.0.0"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  if defined?(RUBY_VERSION) && RUBY_VERSION > '2.2'
    spec.add_development_dependency "test-unit", '~> 3'
  end
end
