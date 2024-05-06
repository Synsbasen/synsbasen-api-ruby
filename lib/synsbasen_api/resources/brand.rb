# frozen_string_literal: true

module SynsbasenApi
  # The `Brand` class provides methods for interacting with brand-related
  # endpoints in the Synsbasen API.
  class Brand < Resource
    extend Findable

    class << self
      # Retrieves information about all brands.
      #
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of all brands.
      def all(expand: [])
        get("/v1/#{resource_name}", expand: expand)
      end

      private

      def resource_name
        "brands"
      end
    end
  end
end
