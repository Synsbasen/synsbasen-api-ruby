# frozen_string_literal: true

module SynsbasenApi
  # The `Brand` class provides methods for interacting with brand-related
  # endpoints in the Synsbasen API.
  class Brand < Client
    class << self
      # Retrieves information about a specific brand based on its ID.
      #
      # @param id [String] The unique identifier of the brand.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of the specified brand.
      def find(id, expand: [])
        get("/v1/brands/#{id}", expand: expand)
      end

      # Retrieves information about all brands.
      #
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of all brands.
      def all(expand: [])
        get("/v1/brands", expand: expand)
      end
    end
  end
end
