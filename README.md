# Synsbasen API
The Synsbasen API Ruby library offers a streamlined interface for interacting with the Synsbasen API in Ruby-based applications. This library is designed to facilitate the retrieval of information related to vehicles and inspections. It incorporates a set of pre-defined classes for API resources, dynamically initializing themselves from API responses, ensuring compatibility across various versions of the Synsbasen API.

Key features of the Synsbasen API Ruby library include:
- Seamless configuration path for swift setup and utilization.
- Pagination helpers for easy navigation through results.
- Built-in mechanisms for parameter serialization in accordance with the Synsbasen API's specifications.

## Documentation
See the [Ruby API docs](https://synsbasen.github.io/synsbasen-api-ruby/) for more information.

## Getting started
Add the following to your application's Gemfile:

```ruby
gem "synsbasen_api"
```

Then run `bundle install`.

Next, you need to add an initializer (config/initializers/synsbasen_api.rb):

```ruby
SynsbasenApi.configure do |config|
  config.api_key = ENV["SYNSBASEN_API_KEY"]
end
```

### Callbacks
The library supports callbacks for the following events:
- `after_request` - called after the request has been made. The callback receives the response object (which is a `Faraday::Response` object) as an argument.

To register a callback, use the following syntax in your initializer:

```ruby
SynsbasenApi.configure do |config|
  config.after_request = ->(response) do
    Rails.logger.info("Synsbasen API response: #{response.body}")
  end
end
```

## Contributing
Feel free to submit a pull request.

Build the gem by running `gem build synsbasen_api.gemspec` in your console.

## Updating documentation
The documentation is generated using [YARD](https://yardoc.org/). To update the documentation, run `yard doc` in your console.

### Push documentation to GitHub Pages
To push the documentation to GitHub Pages:
* check out to `gh-pages`
* merge the changes from `master`
* delete all files except for `doc/`
* move contents from `doc/` to the root directory (`mv doc/* ./`)
* and push the changes to GitHub

## Building the gem
Build the gem by running `gem build synsbasen_api.gemspec` in your console.

## Publishing the gem
Publish the gem by running `gem push synsbasen_api-<version>.gem` in your console.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
