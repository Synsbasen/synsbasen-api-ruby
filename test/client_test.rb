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

  def test_error_responses_preserve_the_http_error_for_non_json_bodies
    { "408" => SynsbasenApi::RequestTimeoutError,
      "504" => SynsbasenApi::GatewayTimeoutError,
      "502" => SynsbasenApi::ServerError,
      "401" => SynsbasenApi::UnauthorizedError }.each do |code, error_class|
      ["<!DOCTYPE html><html>Gateway Timeout</html>", "upstream timed out", "{broken", "", nil].each do |body|
        [:get, :post, :delete].each do |method|
          response = http_response(code, "Proxy error", body)
          with_connection(FakeConnection.new(response)) do
            error = assert_raises(error_class) { SynsbasenApi::Client.public_send(method, "/v1/vehicles") }
            assert_equal code, error.status
            assert_equal({}, error.data)
          end
        end
      end
    end
  end

  def test_all_transport_timeouts_preserve_their_cause
    [Net::OpenTimeout, Net::ReadTimeout, Net::WriteTimeout].each do |timeout_class|
      [:get, :post, :delete].each do |method|
        timeout = timeout_class.new("request timed out")
        with_connection(FakeConnection.new(timeout)) do
          error = assert_raises(SynsbasenApi::RequestTimeoutError) do
            SynsbasenApi::Client.public_send(method, "/v1/vehicles")
          end
          assert_same timeout, error.cause
        end
      end
    end
  end

  def test_invalid_json_in_successful_responses_still_raises
    with_connection(FakeConnection.new(http_response("200", "OK", "<!DOCTYPE html>"))) do
      assert_raises(JSON::ParserError) { SynsbasenApi::Client.get("/v1/vehicles") }
    end
  end

  def test_transport_does_not_retry_on_behalf_of_the_consumer
    assert_equal 0, SynsbasenApi::Client.send(:connection).max_retries
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
