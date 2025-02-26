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

      private

      def resource_name
        "watched_vehicles"
      end
    end
  end
end
