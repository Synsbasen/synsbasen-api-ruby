# frozen_string_literal: true

module SynsbasenApi
  # The `ErrorCode` class provides methods for interacting with error code related
  # endpoints in the Synsbasen API.
  class ErrorCode < Resource
    extend Searchable

    class << self
      private

      def resource_name
        "error_codes"
      end
    end
  end
end
