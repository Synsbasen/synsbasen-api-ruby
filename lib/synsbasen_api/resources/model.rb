# frozen_string_literal: true

module SynsbasenApi
  # The `Model` class provides methods for interacting with model-related
  # endpoints in the Synsbasen API.
  class Model < Resource
    extend Findable
    extend Searchable

    class << self
      # Retrieves information about all models associated with a given brand.
      #
      # @param brand_id [String] The unique identifier of the brand.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of all models associated with the specified brand.
      def all(brand_id, expand: [])
        get("/v1/brands/#{brand_id}/#{resource_name}", expand: expand)
      end

      private

      def resource_name
        "models"
      end
    end
  end
end
