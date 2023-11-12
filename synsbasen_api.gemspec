require_relative "lib/synsbasen_api/version"

Gem::Specification.new do |spec|
  spec.name        = "synsbasen_api"
  spec.version     = SynsbasenApi::VERSION
  spec.authors     = ["Jimmy Poulsen", "Tobias Knudsen"]
  spec.email       = ["jimmypoulsen96@gmail.com", "tobias.knudsen@gmail.com"]
  spec.homepage    = "https://github.com/Synsbasen/synsbasen-api-ruby"
  spec.summary     = "Library that provides a simple way to interact with Synsbasen API"
  spec.description = "Synsbasen API is the easiest way to get access to the Danish vehicle registry."
  spec.license     = "MIT"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/synsbasen/synsbasen-api-ruby/issues",
    "changelog_uri" =>
      "https://github.com/synsbasen/synsbasen-api-ruby/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://synsbasen.github.io/synsbasen-api-ruby",
    "github_repo" => "ssh://github.com/synsbasen/synsbasen-api-ruby",
    "homepage_uri" => "https://api.synsbasen.dk",
    "source_code_uri" => "https://github.com/synsbasen/synsbasen-api-ruby",
  }

  spec.add_runtime_dependency "activesupport", "~> 7"
  spec.add_runtime_dependency "faraday", "~> 2.7"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{lib}/**/*", ]
  end
end
