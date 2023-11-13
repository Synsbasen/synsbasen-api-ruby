# frozen_string_literal: true

require "synsbasen_api/api_response"
require "synsbasen_api/error"
require "faraday"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/enumerable"

module SynsbasenApi
  # The `Client` class serves as the base class for interacting with the Synsbasen API.
  class Client
    DEFAULT_BASE_URL = "https://api.synsbasen.dk".freeze

    class << self
      # Establishes and returns a connection to the Synsbasen API.
      #
      # @return [Faraday::Connection] A Faraday connection instance.
      def connection
        @_connection ||= Faraday.new(url: SynsbasenApi.config[:base_url] || DEFAULT_BASE_URL) do |conn|
          conn.use Faraday::Response::RaiseError
          conn.headers = {
            'Content-Type' => 'application/json',
            'Authorization' => 'Bearer ' + SynsbasenApi.config[:api_key],
          }
        end
      end

      # Sends a GET request to the Synsbasen API.
      #
      # @param path [String] The API endpoint path.
      # @param params [Hash] Query parameters for the request.
      # @param body [Hash] Request body.
      # @return [ApiResponse] An instance of `ApiResponse` containing the API response.
      # @raise [ClientError, ServerError] Raised for client or server errors.
      def get(path, params: {}, body: {}, expand: [])
        response = connection.get(path) do |req|
          req.params = { **params, expand: expand }.compact_blank
          req.body = body.to_json unless body.empty?
        end

        handle_after_request_callback(response)

        ApiResponse.new(JSON.parse(response.body).deep_symbolize_keys)
      rescue => e
        rescue_and_raise_errors(e)
      end

      # Sends a POST request to the Synsbasen API.
      #
      # @param path [String] The API endpoint path.
      # @param params [Hash] Query parameters for the request.
      # @param body [Hash] Request body.
      # @return [ApiResponse] An instance of `ApiResponse` containing the API response.
      # @raise [ClientError, ServerError] Raised for client or server errors.
      def post(path, params: {}, body: {}, expand: [])
        response = connection.post(path) do |req|
          req.params = params
          req.body = { **body, expand: expand }.compact_blank.to_json
        end

        handle_after_request_callback(response)

        ApiResponse.new(JSON.parse(response.body).deep_symbolize_keys)
      rescue => e
        rescue_and_raise_errors(e)
      end

      private

      # Rescues and raises specific errors based on the type of Faraday error encountered.
      #
      # @param e [Exception] The exception to handle.
      # @raise [ClientError, ServerError] Raised for client or server errors.
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

      # Calls the after_request callback if configured in the SynsbasenApi.
      #
      # @param response [Faraday::Response] The Faraday response object.
      # @return [void]
      def handle_after_request_callback(response)
        return unless SynsbasenApi.config[:after_request]

        SynsbasenApi.config[:after_request].call(response)
      end
    end
  end
end
