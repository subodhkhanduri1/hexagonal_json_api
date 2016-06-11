# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hexagonal_json_api/version'

Gem::Specification.new do |spec|
  spec.name          = "hexagonal_json_api"
  spec.version       = HexagonalJsonApi::VERSION
  spec.authors       = ["Subodh Khanduri"]
  spec.email         = ["subodhkhanduri1@gmail.com"]

  spec.summary       = %q{Hexagonal code design for JSON APIs}
  spec.description   = %q{APIs should have a way to separate the different layers based on their responsibilities. This gem provides a simple pattern to do so.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 4.0.0", "< 5.0.0"

  spec.add_development_dependency "bundler", "~> 1.12.0"
  spec.add_development_dependency "rake", "~> 11.2.0"
  spec.add_development_dependency "rspec", "~> 3.4.0"
end
