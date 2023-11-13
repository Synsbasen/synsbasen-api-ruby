# frozen_string_literal: true

module SynsbasenApi
  # The `Inspection` class provides methods for interacting with inspection-related
  # endpoints in the Synsbasen API.
  class Inspection < Client
    class << self
      # Performs a search for inspections based on the provided criteria.
      #
      # @param args [Hash] Additional parameters to customize the search.
      # @option args [String] :method The search method. Default is 'SELECT'.
      # @return [ApiResponse] An instance of `ApiResponse` containing search results.
      def search(args = {}, expand: [])
        post(
          "/v1/inspections/search",
          body: {
            method: 'SELECT',
          }.merge(args),
          expand: expand
        )
      end
    end
  end
end
