module SynsbasenApi
  class InspectionTestCenter < Client
    class << self
      def all
        get(
          "/v1/inspection_test_centers"
        )
      end
    end
  end
end
