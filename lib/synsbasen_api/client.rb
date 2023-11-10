require "synsbasen_api/api_response"
require "synsbasen_api/error"
require "faraday"
require "active_support/core_ext/hash/keys"

module SynsbasenApi
  class Client
    class << self
      def connection
        @_connection ||= Faraday.new(url: SynsbasenApi.config[:base_url]) do |conn|
          conn.use Faraday::Response::RaiseError
          conn.headers = {
            'Content-Type' => 'application/json',
            'Authorization' => 'Bearer ' + SynsbasenApi.config[:api_key],
          }
        end
      end

      def get(path, params: {}, body: {})
        response = connection.get(path) do |req|
          req.params = params
          req.body = body unless body.empty?
        end

        ApiResponse.new(JSON.parse(response.body).deep_symbolize_keys)
      rescue => e
        rescue_and_raise_errors(e)
      end

      def post(path, params: {}, body: {})
        response = connection.post(path) do |req|
          req.params = params
          req.body = body
        end

        ApiResponse.new(JSON.parse(response.body).deep_symbolize_keys)
      rescue => e
        rescue_and_raise_errors(e)
      end

      private

      def rescue_and_raise_errors(e)
        case e
        when Faraday::UnauthorizedError
          raise ClientError.new(e.message, e.response[:status], {})
        when Faraday::ClientError
          raise ClientError.new(e.message, e.response[:status], JSON.parse(e.response[:body]).deep_symbolize_keys)
        when Faraday::ServerError
          raise ServerError.new(e.message, e.response[:status], JSON.parse(e.response[:body]).deep_symbolize_keys)
        else
          raise e
        end
      end
    end
  end
end
