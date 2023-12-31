# frozen_string_literal: true

module SynsbasenApi
  # The `Model` class provides methods for interacting with model-related
  # endpoints in the Synsbasen API.
  class Model < Client
    class << self
      # Retrieves information about a specific model based on its ID.
      #
      # @param id [String] The unique identifier of the model.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of the specified model.
      def find(id, expand: [])
        get("/v1/models/#{id}", expand: expand)
      end

      # Retrieves information about all models associated with a given brand.
      #
      # @param brand_id [String] The unique identifier of the brand.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of all models associated with the specified brand.
      def all(brand_id, expand: [])
        get("/v1/brands/#{brand_id}/models", expand: expand)
      end
    end
  end
end
