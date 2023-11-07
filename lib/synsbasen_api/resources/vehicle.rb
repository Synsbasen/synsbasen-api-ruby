module SynsbasenApi
  class Vehicle < Client
    def self.find(id)
      get("/v1/vehicles/#{id}")
    end

    def self.find_by_registration(registration)
      get("/v1/vehicles/registration/#{registration}")
    end

    def self.search(args = {})
      post(
        "/v1/vehicles/search",
        body: {
          method: 'SELECT',
        }.merge(args).to_json
      )
    end
  end
end
