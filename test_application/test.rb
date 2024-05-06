require 'bundler/setup'
Bundler.require

require 'dotenv'
Dotenv.load('./.env')

SynsbasenApi.configure do |config|
  config.api_key = ENV.fetch("API_KEY")
  config.after_request = ->(response) { puts response.class }
end

# Vehicles
puts "Vehicles"
begin
  response = SynsbasenApi::Vehicle.find_by_registration("AS67902", expand: %i[equipment engine])
  puts response.data[:id]
  puts response.data[:registration]
  puts response.data[:equipment]
  puts response.data[:engine]
rescue SynsbasenApi::ClientError => e
  binding.irb
end

response = SynsbasenApi::Vehicle.find(9000000000970539, expand: %i[equipment engine])
puts response.data[:id]
puts response.data[:registration]
puts response.data[:equipment]
puts response.data[:engine]

args = {
  query: {
    registration_start: "AS679",
  },
  sorts: 'registration ASC',
}
response = SynsbasenApi::Vehicle.search(args, expand: %i[equipment])
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

puts "Inspection test centers in Aalborg"
aalborg_itc = SynsbasenApi::InspectionTestCenter.search({
  query: {
    zip_in: [9000, 9200, 9220],
  },
  method: 'SELECT',
  per_page: 25,
}).data

puts aalborg_itc.map { |i| i[:name] }

puts ""

# Brands
puts "Brands"
response = SynsbasenApi::Brand.all
puts response.data.first(10).map { |i| i[:name] }

# Leasing periods
puts "Leasing periods"
args = {
  query: {
    vehicle_id: 1004501200018020,
  },
  method: 'SELECT',
  per_page: 10,
  page: 1,
}

response = SynsbasenApi::LeasingPeriod.search(args)
puts response
