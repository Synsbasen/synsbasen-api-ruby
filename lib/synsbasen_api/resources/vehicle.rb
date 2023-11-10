module SynsbasenApi
  class Vehicle < Client
    class << self
      def find(id)
        get("/v1/vehicles/#{id}")
      end

      def find_by_registration(registration)
        get("/v1/vehicles/registration/#{registration}")
      end

      def search(args = {})
        post(
          "/v1/vehicles/search",
          body: {
            method: 'SELECT',
          }.merge(args).to_json
        )
      end
    end
  end
end
