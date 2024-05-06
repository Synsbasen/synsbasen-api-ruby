# frozen_string_literal: true

module SynsbasenApi
  # The `InspectionTestCenter` class provides methods for interacting with inspection test center-related
  # endpoints in the Synsbasen API.
  class InspectionTestCenter < Resource
    extend Searchable

    class << self
      # Retrieves information about all inspection test centers.
      #
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of all inspection test centers.
      def all
        get("/v1/#{resource_name}")
      end

      private

      def resource_name
        "inspection_test_centers"
      end
    end
  end
end
