# Synsbasen API
This is the official Ruby gem for the Synsbasen API.

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

### Example
```ruby
SynsbasenApi::Vehicle.find_by_registration_number("DS88784")
```

## Contributing
Feel free to submit a pull request. We have the ambition to support other providers than Auth0 as well.

Build the gem by running `gem build synsbasen_api.gemspec` in your console.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
