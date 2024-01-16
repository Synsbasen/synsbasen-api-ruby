# frozen_string_literal: true

module SynsbasenApi
  # The `ApiResponse` class represents the response structure from the Synsbasen API.
  class ApiResponse
    # @return [Hash] The data included in the API response.
    attr_reader :data

    # @return [Numeric] The cost associated with the API response.
    attr_reader :cost

    # @return [Boolean] Indicates whether there is more data available in the response.
    attr_reader :has_more

    # @return [Numeric] The total number of pages available.
    attr_reader :total_pages

    # Initializes a new instance of `ApiResponse` with the provided response data.
    #
    # @param response [Hash] The response data from the API.
    # @option response [Hash] :data The data included in the API response.
    # @option response [Numeric] :cost The cost associated with the API response.
    # @option response [Boolean] :has_more Indicates whether there is more data available in the response.
    def initialize(response)
      @data = response[:data]
      @cost = response[:cost]

      %i[has_more total_pages].each do |key|
        instance_variable_set("@#{key}", response[key]) if response.key?(key)
      end
    end
  end
end
