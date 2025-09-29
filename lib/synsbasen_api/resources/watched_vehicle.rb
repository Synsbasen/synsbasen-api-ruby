# frozen_string_literal: true

module SynsbasenApi
  # The `WatchedVehicle` class provides methods for interacting with watched vehicle related
  # endpoints in the Synsbasen API.
  class WatchedVehicle < Resource
    class << self
      # Retrieves all watched vehicles.
      #
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of all watched vehicles.
      def all
        get("/v1/#{resource_name}")
      end

      # Creates a new watched vehicle.
      #
      # @param vehicle_id [Integer] The ID of the vehicle to be watched.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of the newly created watched vehicle.
      def subscribe(vehicle_id)
        post("/v1/#{resource_name}", body: { vehicle_id: vehicle_id })
      rescue SynsbasenApi::ClientError => e
        raise VehicleAlreadySubscribedError.new(e.message, e.status, e.data) if e.status == "409"
        raise e
      end

      # Deletes a watched vehicle.
      #
      # @param vehicle_id [Integer] The ID of the vehicle to be unwatched.
      # @return [ApiResponse] An instance of `ApiResponse` indicating the success
      #   of the unwatch operation.
      def unsubscribe(vehicle_id)
        delete("/v1/#{resource_name}/#{vehicle_id}")
      end

      private

      def resource_name
        "watched_vehicles"
      end
    end
  end
end
