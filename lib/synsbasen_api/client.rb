# frozen_string_literal: true

require "synsbasen_api/api_response"
require "synsbasen_api/error"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/enumerable"
require "net/http"
require "uri"
require "json"

module SynsbasenApi
  # The `Client` class serves as the base class for interacting with the Synsbasen API.
  class Client
    DEFAULT_BASE_URL = "https://api.synsbasen.dk".freeze

    class << self
      # Sends a GET request to Synsbasen API.
      #
      # @param path [String] The API endpoint path.
      # @param params [Hash] Query parameters for the request.
      # @param expand [Array] List of fields to expand in the response.
      # @return [ApiResponse] An instance of `ApiResponse` containing the API response.
      # @raise [ClientError, ServerError] Raised for client or server errors.
      def get(path, params: {}, expand: [])
        request = build_request(path, method: Net::HTTP::Get, params: params, expand: expand)

        response = connection.request(request)

        raise_errors(response)

        handle_after_request_callback(response)

        ApiResponse.new(JSON.parse(response.body).deep_symbolize_keys)
      end

      # Sends a POST request to Synsbasen API.
      #
      # @param path [String] The API endpoint path.
      # @param params [Hash] Query parameters for the request.
      # @param body [Hash] Request body.
      # @param expand [Array] List of fields to expand in the response.
      # @return [ApiResponse] An instance of `ApiResponse` containing the API response.
      # @raise [ClientError, ServerError] Raised for client or server errors.
      def post(path, params: {}, body: {}, expand: [])
        request = build_request(path, method: Net::HTTP::Post, params: params, body: body, expand: expand)

        response = connection.request(request)

        raise_errors(response)

        handle_after_request_callback(response)

        ApiResponse.new(JSON.parse(response.body).deep_symbolize_keys)
      end

      private

      # Establishes and returns a connection to Synsbasen API.
      #
      # @return [Net::HTTP] A Net::HTTP connection instance.
      def connection
        uri = URI.parse(SynsbasenApi.config[:base_url] || DEFAULT_BASE_URL)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == 'https'
        http
      end

      # Builds a Net::HTTP request object with the specified parameters.
      #
      # @param path [String] The API endpoint path.
      # @param params [Hash] Query parameters for the request.
      # @param body [Hash] Request body.
      # @param expand [Array] List of fields to expand in the response.
      # @param method [Net::HTTP::Get, Net::HTTP::Post] The HTTP method to use.
      #
      # @return [Net::HTTP::Get, Net::HTTP::Post] A Net::HTTP request object.
      def build_request(path, method:, params: {}, body: {}, expand: [])
        uri = URI.parse(SynsbasenApi.config[:base_url] || DEFAULT_BASE_URL)
        uri.path = path
        uri.query = URI.encode_www_form(params.merge(expand: expand))

        request = method.new(uri)
        request.body = body.compact_blank.to_json if method == Net::HTTP::Post
        request['Content-Type'] = 'application/json'
        request['Authorization'] = "Bearer #{SynsbasenApi.config[:api_key]}"

        request
      end

      # Rescues and raises specific errors based on the type of Net::HTTP error encountered.
      #
      # @param e [Exception] The exception to handle.
      # @raise [ClientError, ServerError] Raised for client or server errors.
      def raise_errors(response)
        case response
        when Net::HTTPUnauthorized
          raise ClientError.new(response.message, response.code, {})
        when Net::HTTPClientError, Net::HTTPBadRequest, Net::HTTPForbidden, Net::HTTPNotFound
          raise ClientError.new(response.message, response.code, JSON.parse(response.body).deep_symbolize_keys)
        when Net::HTTPServerError
          raise ServerError.new(response.message, response.code, {})
        else
          response
        end
      end

      # Calls the after_request callback if configured in the SynsbasenApi.
      #
      # @param response [Net::HTTPResponse] The Net::HTTPResponse object.
      # @return [void]
      def handle_after_request_callback(response)
        return unless SynsbasenApi.config[:after_request]

        SynsbasenApi.config[:after_request].call(response)
      end
    end
  end
end
