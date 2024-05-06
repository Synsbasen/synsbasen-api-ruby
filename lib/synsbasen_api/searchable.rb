# frozen_string_literal: true

module SynsbasenApi
  module Searchable
    # Performs a search for resources based on the provided criteria.
    #
    # @param args [Hash] Additional parameters to customize the search.
    # @option args [String] :method The search method. Default is 'SELECT'.
    # @return [ApiResponse] An instance of `ApiResponse` containing search results.
    def search(args = {}, expand: nil)
      post(
        "/v1/#{resource_name}/search",
        body: {
          method: 'SELECT',
        }.merge(args),
        expand: expand
      )
    end
  end
end
