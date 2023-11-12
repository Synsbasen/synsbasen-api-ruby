# frozen_string_literal: true

module SynsbasenApi
  # The `TestCenter` class provides methods for interacting with test center-related
  # endpoints in the Synsbasen API.
  class TestCenter < Client
    class << self
      # Retrieves information about all test centers.
      #
      # @return [ApiResponse] An instance of `ApiResponse` containing details
      #   of all test centers.
      def all
        get("/v1/test_centers")
      end
    end
  end
end
