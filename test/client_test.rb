# frozen_string_literal: true

require "minitest/autorun"
require "synsbasen_api"

class SynsbasenApiClientTest < Minitest::Test
  FakeConnection = Struct.new(:response) do
    def request(_request)
      response.is_a?(Exception) ? raise(response) : response
    end
  end

  def setup
    SynsbasenApi.configure do |config|
      config.api_key = "test-api-key"
      config.base_url = "https://api.example.test"
      config.after_request = nil
    end
  end

  def test_http_504_raises_gateway_timeout_error
    response = http_response("504", "Gateway Time-out", '{"error":"upstream timeout"}')

    with_connection(FakeConnection.new(response)) do
      error = assert_raises(SynsbasenApi::GatewayTimeoutError) do
        SynsbasenApi::Client.get("/v1/vehicles")
      end

      assert_kind_of SynsbasenApi::RequestTimeoutError, error
      assert_equal "504", error.status
      assert_equal({ error: "upstream timeout" }, error.data)
    end
  end

  def test_transport_timeout_raises_request_timeout_error
    timeout = Net::ReadTimeout.new("read timed out")

    with_connection(FakeConnection.new(timeout)) do
      error = assert_raises(SynsbasenApi::RequestTimeoutError) do
        SynsbasenApi::Client.get("/v1/vehicles")
      end

      assert_equal timeout.message, error.message
      assert_same timeout, error.cause
    end
  end

  def test_http_status_mapping_does_not_build_constant_names_from_response_messages
    response = http_response("400", "Bad-Request", "{}")

    error = assert_raises(SynsbasenApi::BadRequestError) do
      SynsbasenApi::Client.send(:raise_errors, response)
    end

    assert_equal "400", error.status
  end

  private

  def http_response(code, message, body)
    response_class = Net::HTTPResponse::CODE_TO_OBJ.fetch(code)
    response = response_class.new("1.1", code, message)
    response.body = body
    response.instance_variable_set(:@read, true)
    response
  end

  def with_connection(connection)
    singleton = class << SynsbasenApi::Client; self; end
    original = singleton.instance_method(:connection)
    singleton.send(:define_method, :connection) { connection }
    yield
  ensure
    singleton.send(:define_method, :connection, original)
    singleton.send(:private, :connection)
  end
end
