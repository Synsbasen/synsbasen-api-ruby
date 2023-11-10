module SynsbasenApi
  class Brand < Client
    class << self
      def find(id)
        get("/v1/brands/#{id}")
      end

      def all
        get("/v1/brands")
      end
    end
  end
end
