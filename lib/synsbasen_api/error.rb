# frozen_string_literal: true

module SynsbasenApi
  # The `Error` module provides custom error classes for handling API errors.
  class Error < StandardError
    # @return [String] The error message.
    attr_accessor :message

    # @return [String] The HTTP status code associated with the error.
    attr_accessor :status

    # @return [Hash] Additional data associated with the error.
    attr_accessor :data

    # Initializes a new instance of `Error`.
    #
    # @param msg [String] The error message.
    # @param status [String] The HTTP status code associated with the error.
    # @param data [Hash] Additional data associated with the error.
    def initialize(msg = '', status = '', data = {})
      @message = msg
      @status = status
      @data = data
    end
  end

  # The `ClientError` class represents errors that occur on the client side (4xx status codes).
  class ClientError < Error; end

  # The `ServerError` class represents errors that occur on the server side (5xx status codes).
  class ServerError < Error; end

  # The `VehicleAlreadySubscribedError` class represents errors that occur when a vehicle is already being watched.
  class VehicleAlreadySubscribedError < ClientError; end
end
