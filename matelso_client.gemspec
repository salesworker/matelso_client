# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matelso_client/version'

Gem::Specification.new do |spec|
  spec.name          = "matelso_client"
  spec.version       = MatelsoClient::VERSION
  spec.authors       = ["kholdrex"]
  spec.email         = ["alexandrkholodniak@gmail.com"]

  spec.summary       = %q{Matelso Client}
  spec.description   = %q{Matelso Client}
  spec.homepage      = "https://github.com/salesworker/matelso_client"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http:/www.kholdrex.in.ua"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'savon', '~> 2.10.0'
end
