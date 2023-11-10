module SynsbasenApi
  class TestCenter < Client
    class << self
      def all
        get(
          "/v1/test_centers"
        )
      end
    end
  end
end
