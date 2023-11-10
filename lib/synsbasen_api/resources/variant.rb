module SynsbasenApi
  class Variant < Client
    class << self
      def find(id)
        get("/v1/variants/#{id}")
      end

      def all(model_id)
        get("/v1/models/#{model_id}/variants")
      end
    end
  end
end
