# frozen_string_literal: true

module SynsbasenApi
  # The `Version` class provides methods for interacting with version-related
  # endpoints in the Synsbasen API.
  class Version < Client
    class << self
      # Retrieves information about a specific version based on its ID.
      #
      # @param id [String] The unique identifier of the version.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of the specified version.
      def find(id, expand: [])
        get("/v1/versions/#{id}", expand: expand)
      end

      # Retrieves information about all versions associated with a given variant.
      #
      # @param variant_id [String] The unique identifier of the variant.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of all versions associated with the specified variant.
      def all(variant_id, expand: [])
        get("/v1/variants/#{variant_id}/versions", expand: expand)
      end
    end
  end
end
