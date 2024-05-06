# frozen_string_literal: true

module SynsbasenApi
  # The `Variant` class provides methods for interacting with variant-related
  # endpoints in the Synsbasen API.
  class Variant < Resource
    extend Findable

    class << self
      # Retrieves information about all variants associated with a given model.
      #
      # @param model_id [String] The unique identifier of the model.
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of all variants associated with the specified model.
      def all(model_id, expand: [])
        get("/v1/models/#{model_id}/#{resource_name}", expand: expand)
      end

      private

      def resource_name
        "variants"
      end
    end
  end
end
