module SynsbasenApi
  class ApiResponse
    attr_reader :data, :cost, :has_more

    def initialize(response)
      @data = response[:data]
      @cost = response[:cost]
      @has_more = response[:has_more] || false
    end
  end
end
