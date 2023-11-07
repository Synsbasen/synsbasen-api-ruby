require 'bundler/setup'
Bundler.require

SynsbasenApi.configure do |config|
  config.base_url = "http://localhost:3000"
  config.api_key = "basic_api_key"
end

vehicle = SynsbasenApi::Vehicle.find_by_registration("AS67902")

vehicles = SynsbasenApi::Vehicle.search({ registration: "AS679" })
