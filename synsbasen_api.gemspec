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

  spec.add_runtime_dependency "activesupport", "~> 7.1"
  spec.add_runtime_dependency "faraday", "~> 2.7"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{lib}/**/*", ]
  end
end
