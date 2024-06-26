# frozen_string_literal: true

module SynsbasenApi
  # The `Version` class provides methods for interacting with version-related
  # endpoints in the Synsbasen API.
  class Version < Resource
    extend Findable
    extend Searchable

    class << self
      # Retrieves information about all versions associated with a given variant.
      #
      # @param variant_id [String] The unique identifier of the variant.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of all versions associated with the specified variant.
      def all(variant_id, expand: [])
        get("/v1/variants/#{variant_id}/#{resource_name}", expand: expand)
      end

      private

      def resource_name
        "versions"
      end
    end
  end
end
