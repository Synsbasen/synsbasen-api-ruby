module SynsbasenApi
  class Inspection < Client
    class << self
      def search(args = {})
        post(
          "/v1/inspections/search",
          body: {
            method: 'SELECT',
          }.merge(args).to_json
        )
      end
    end
  end
end
