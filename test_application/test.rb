require 'bundler/setup'
Bundler.require

require 'dotenv'
Dotenv.load('./.env')

SynsbasenApi.configure do |config|
  config.api_key = ENV.fetch("API_KEY")
end

# Vehicles
puts "Vehicles"
begin
  response = SynsbasenApi::Vehicle.find_by_registration("AS67902", expand: %i[equipment])
  puts response.data[:registration]
  puts response.data[:equipment]
rescue => e
  binding.irb
end

response = SynsbasenApi::Vehicle.search({ registration: "AS679" }, expand: %i[equipment])
puts response.data.map { |v| v[:registration] }
puts response.data.map { |v| v[:equipment] }

puts ""

puts "Inspections"

# Inspections
test_center_ids = [1522, 284]
start_date = "2023-01-01"
end_date = "2023-12-31"

args = {
  query: {
    inspection_test_center_id_in: test_center_ids,
    date_gteq: start_date,
    date_lteq: end_date,
  },
  method: 'SELECT',
  per_page: 20,
  page: 1,
  sorts: 'date ASC'
}

response = SynsbasenApi::Inspection.search(args)
puts response.data.map { |i| i[:date] + " " + i[:time] }

puts ""

# Inspection test_application centers
puts "Inspection test_application centers"
response = SynsbasenApi::InspectionTestCenter.all
puts response.data.first(10).map { |i| i[:name] }

puts ""

# Brands
puts "Brands"
response = SynsbasenApi::Brand.all
puts response.data.first(10).map { |i| i[:name] }
