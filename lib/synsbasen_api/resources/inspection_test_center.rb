# frozen_string_literal: true

module SynsbasenApi
  # The `InspectionTestCenter` class provides methods for interacting with inspection test center-related
  # endpoints in the Synsbasen API.
  class InspectionTestCenter < Client
    class << self
      # Retrieves information about all inspection test centers.
      #
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of all inspection test centers.
      def all
        get("/v1/inspection_test_centers")
      end

      # Performs a search for inspection test centers based on the provided criteria.
      #
      # @param args [Hash] Additional parameters to customize the search.
      # @option args [String] :method The search method. Default is 'SELECT'.
      # @return [ApiResponse] An instance of `ApiResponse` containing search results.
      def search(args = {}, expand: [])
        post(
          "/v1/inspection_test_centers/search",
          body: {
            method: 'SELECT',
          }.merge(args),
          expand: expand
        )
      end
    end
  end
end
