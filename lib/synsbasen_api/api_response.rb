module SynsbasenApi
  class ApiResponse
    attr_reader :data, :cost

    def initialize(response)
      @data = response[:data]
      @cost = response[:cost]
    end

    def each(&block)
      data.map { |data| self.class.new({ data: data }) }.each(&block)
    end

    def first
      data.first
    end

    def last
      data.last
    end

    def method_missing(name, *args, &block)
      attribute_name = name.to_sym

      if data.key?(attribute_name)
        data[attribute_name]
      else
        super
      end
    end

    def respond_to_missing?(name, include_private = false)
      true
    end
  end
end
