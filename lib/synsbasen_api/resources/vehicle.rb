# frozen_string_literal: true

require 'cgi/escape'

module SynsbasenApi
  # The `Vehicle` class provides methods for interacting with vehicle-related
  # endpoints in the Synsbasen API. It extends the `Client` class.
  class Vehicle < Resource
    extend Findable
    extend Searchable

    class << self
      # Retrieves information about a vehicle based on its registration number.
      #
      # @param registration [String] The registration number of the vehicle.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of the specified vehicle.
      def find_by_registration(registration, expand: [])
        escaped_registration = CGI.escape(registration)
        get("/v1/#{resource_name}/registration/#{escaped_registration}", expand: expand)
      end

      # Retrieves information about a vehicle based on its VIN (Vehicle Identification Number).
      #
      # @param vin [String] The VIN of the vehicle.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of the specified vehicle.
      def find_by_vin(vin, expand: [])
        get("/v1/#{resource_name}/vin/#{vin}", expand: expand)
      end

      private

      def resource_name
        "vehicles"
      end
    end
  end
end
