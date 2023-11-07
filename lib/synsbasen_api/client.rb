require "synsbasen_api/api_response"
require "faraday"
require "active_support/core_ext/hash/keys"

module SynsbasenApi
  class Client
    def self.connection
      puts SynsbasenApi.config
      @_connection ||= Faraday.new(url: SynsbasenApi.config[:base_url]) do |conn|
        conn.use Faraday::Response::RaiseError
        conn.headers = {
          'Content-Type' => 'application/json',
          'Authorization' => 'Bearer ' + SynsbasenApi.config[:api_key],
        }
      end
    end

    def self.get(path, params: {}, body: {})
      response = connection.get(path) do |req|
        req.params = params
        req.body = body unless body.empty?
      end

      ApiResponse.new(JSON.parse(response.body).deep_symbolize_keys)
    rescue Faraday::ClientError => e
      raise ClientError.new(e.message, e.response[:status], JSON.parse(e.response[:body]).deep_symbolize_keys)
    rescue Faraday::ServerError => e
      raise ServerError.new(e.message, e.response[:status], JSON.parse(e.response[:body]).deep_symbolize_keys)
    end

    def self.post(path, params: {}, body: {})
      response = connection.post(path) do |req|
        req.params = params
        req.body = body
      end

      ApiResponse.new(JSON.parse(response.body).deep_symbolize_keys)
    rescue Faraday::ClientError => e
      raise ClientError.new(e.message, e.response[:status], JSON.parse(e.response[:body]).deep_symbolize_keys)
    rescue Faraday::ServerError => e
      raise ServerError.new(e.message, e.response[:status], JSON.parse(e.response[:body]).deep_symbolize_keys)
    end
  end
end
