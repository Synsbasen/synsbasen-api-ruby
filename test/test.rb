require 'bundler/setup'
Bundler.require

SynsbasenApi.configure do |config|
  config.base_url = "http://localhost:3000"
  config.api_key = "basic_api_key"
end

response = SynsbasenApi::Vehicle.find_by_registration("AS67902")
puts response.data[:registration]

response = SynsbasenApi::Vehicle.search({ registration: "AS679" })
puts response.data.map { |v| v[:registration] }
