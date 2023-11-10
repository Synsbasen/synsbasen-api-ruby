module SynsbasenApi
  class Version < Client
    class << self
      def find(id)
        get("/v1/versions/#{id}")
      end

      def all(variant_id)
        get("/v1/variants/#{variant_id}/versions")
      end
    end
  end
end
