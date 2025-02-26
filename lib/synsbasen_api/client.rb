# frozen_string_literal: true

require "synsbasen_api/api_response"
require "synsbasen_api/error"
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

        ApiResponse.new(parse_json(response.body))
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

        ApiResponse.new(parse_json(response.body))
      end

      # Sends a DELETE request to Synsbasen API.
      #
      # @param path [String] The API endpoint path.
      # @param params [Hash] Query parameters for the request.
      # @param body [Hash] Request body.
      # @return [ApiResponse] The API response.
      # @raise [ClientError, ServerError] Raised for client or server errors.
      def delete(path, params = {}, body = {})
        request = build_request(path, method: Net::HTTP::Delete, params: params, body: body)

        response = connection.request(request)

        raise_errors(response)

        handle_after_request_callback(response)

        ApiResponse.new(parse_json(response.body))
      end

      private

      # Establishes and returns a connection to Synsbasen API.
      #
      # @return [Net::HTTP] A Net::HTTP connection instance.
      def connection
        uri = URI.parse(SynsbasenApi.config[:base_url] || DEFAULT_BASE_URL)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == "https"
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
        query = params
        query.merge!('expand[]': expand) unless expand.nil? || expand.empty?
        uri.query = URI.encode_www_form(query)

        request = method.new(uri)
        request.body = body.reject { |i| i.nil? || i.empty? }.to_json if method == Net::HTTP::Post
        request["Content-Type"] = "application/json"
        request["Authorization"] = "Bearer #{SynsbasenApi.config[:api_key]}"

        request
      end

      # Raises specific errors based on the type of Net::HTTP error encountered.
      #
      # @param e [Exception] The exception to handle.
      # @raise [ClientError, ServerError] Raised for client or server errors.
      def raise_errors(response)
        case response
        when Net::HTTPUnauthorized
          raise ClientError.new(response.message, response.code, {})
        when Net::HTTPClientError, Net::HTTPBadRequest, Net::HTTPForbidden, Net::HTTPNotFound
          raise ClientError.new(response.message, response.code, parse_json(response.body))
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

      # Parses a JSON string into a hash with symbolized keys.
      #
      # @param data [String] The JSON string to parse.
      # @return [Hash] The parsed JSON string as a hash with symbolized keys.
      def parse_json(data)
        data ||= "{}"

        deep_symbolize_keys(JSON.parse(data))
      end

      # Recursively converts all keys in a hash to symbols.
      #
      # This method is used to convert all keys in the API response to symbols.
      #
      # @param hash [Hash] The hash to convert.
      # @return [Hash] The hash with all keys converted to symbols.
      # @example
      #  deep_symbolize_keys({ "key" => "value" }) #=> { key: "value" }
      #  deep_symbolize_keys({ "key" => { "nested_key" => "value" } }) #=> { key: { nested_key: "value" } }
      def deep_symbolize_keys(obj)
        case obj
        when Hash
          obj.each_with_object({}) do |(key, value), result|
            new_key = key.is_a?(String) ? key.to_sym : key
            new_value = deep_symbolize_keys(value)
            result[new_key] = new_value
          end
        when Array
          obj.map { |value| deep_symbolize_keys(value) }
        else
          obj
        end
      end
    end
  end
end
