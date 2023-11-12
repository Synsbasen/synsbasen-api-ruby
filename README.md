# Synsbasen API
The Synsbasen API Ruby library offers a streamlined interface for interacting with the Synsbasen API in Ruby-based applications. This library is designed to facilitate the retrieval of information related to vehicles and inspections. It incorporates a set of pre-defined classes for API resources, dynamically initializing themselves from API responses, ensuring compatibility across various versions of the Synsbasen API.

Key features of the Synsbasen API Ruby library include:
- Seamless configuration path for swift setup and utilization.
- Pagination helpers for easy navigation through results*.
- Built-in mechanisms for parameter serialization in accordance with the Synsbasen API's specifications.

*coming soon

## Documentation
See the [Ruby API docs](https://synsbasen.github.io/synsbasen-api-ruby/) for more information.

## Getting started
Add the following to your application's Gemfile:

```ruby
gem "synsbasen_api", github: "Synsbasen/synsbasen-api-ruby", branch: "master"
```

Then run `bundle install`.

Next, you need to add an initializer (config/initializers/synsbasen_api.rb):

```ruby
SynsbasenApi.configure do |config|
  config.api_key = ENV["SYNSBASEN_API_KEY"]
end
```

## Contributing
Feel free to submit a pull request. We have the ambition to support other providers than Auth0 as well.

Build the gem by running `gem build synsbasen_api.gemspec` in your console.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
