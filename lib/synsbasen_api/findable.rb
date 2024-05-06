# frozen_string_literal: true

module SynsbasenApi
  # Provides a method to find a resource by its ID.
  #
  # This module is intended to be extended in classes that represent resources.
  module Findable
    # Retrieves information about a specific record based on its ID.
    #
    # @param id [String] The unique identifier of the record.
    # @param expand [Array<String>] A list of related resources to include in the response.
    # @return [ApiResponse] An instance of `ApiResponse` containing details
    #   of the specified version.
    def find(id, expand: [])
      get("/v1/#{resource_name}/#{id}", expand: expand)
    end
  end
end
