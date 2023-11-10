module SynsbasenApi
  class Model < Client
    class << self
      def find(id)
        get("/v1/models/#{id}")
      end

      def all(brand_id)
        get("/v1/brands/#{brand_id}/models")
      end
    end
  end
end
