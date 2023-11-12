require_relative "lib/synsbasen_api/version"

Gem::Specification.new do |spec|
  spec.name        = "synsbasen_api"
  spec.version     = SynsbasenApi::VERSION
  spec.authors     = ["Jimmy Poulsen", "Tobias Knudsen"]
  spec.email       = ["jimmypoulsen96@gmail.com", "tobias.knudsen@gmail.com"]
  spec.homepage    = "https://github.com/Synsbasen/synsbasen-api-ruby"
  spec.summary     = "Library that provides a simple way to interact with Synsbasen API"
  spec.description = "Description of Synsbasen API."
  spec.license     = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.add_runtime_dependency "activesupport", "~> 7"
  spec.add_runtime_dependency "faraday", "~> 2.7"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{lib}/**/*", ]
  end
end
