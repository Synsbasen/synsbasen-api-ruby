module SynsbasenApi
  class ApiResponse
    attr_reader :data, :cost

    def initialize(response)
      @data = response[:data]
      @cost = response[:cost]
    end
  end
end
