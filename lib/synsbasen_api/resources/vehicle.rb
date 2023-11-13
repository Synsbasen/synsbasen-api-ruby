# frozen_string_literal: true

module SynsbasenApi
  # The `Vehicle` class provides methods for interacting with vehicle-related
  # endpoints in the Synsbasen API. It extends the `Client` class.
  class Vehicle < Client
    class << self
      # Retrieves information about a specific vehicle based on its ID.
      #
      # @param id [String] The unique identifier of the vehicle.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of the specified vehicle.
      def find(id)
        get("/v1/vehicles/#{id}")
      end

      # Retrieves information about a vehicle based on its registration number.
      #
      # @param registration [String] The registration number of the vehicle.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of the specified vehicle.
      def find_by_registration(registration)
        get("/v1/vehicles/registration/#{registration}")
      end

      # Retrieves information about a vehicle based on its VIN (Vehicle Identification Number).
      #
      # @param vin [String] The VIN of the vehicle.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of the specified vehicle.
      def find_by_vin(vin)
        get("/v1/vehicles/vin/#{vin}")
      end

      # Performs a search for vehicles based on the provided criteria.
      #
      # @param args [Hash] Additional parameters to customize the search.
      # @option args [String] :method The search method. Default is 'SELECT'.
      # @return [ApiResponse] An instance of `ApiResponse` containing search results.
      def search(args = {})
        post(
          "/v1/vehicles/search",
          body: {
            method: 'SELECT',
          }.merge(args).to_json
        )
      end
    end
  end
end
