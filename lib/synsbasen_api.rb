# frozen_string_literal: true

require "synsbasen_api/client"
require "synsbasen_api/resource"
require "synsbasen_api/searchable"
require "synsbasen_api/resources/brand"
require "synsbasen_api/resources/inspection"
require "synsbasen_api/resources/inspection_test_center"
require "synsbasen_api/resources/model"
require "synsbasen_api/resources/test_center"
require "synsbasen_api/resources/vehicle"
require "synsbasen_api/resources/variant"
require "synsbasen_api/resources/version"
require "ostruct"

# The `SynsbasenApi` module provides a configuration mechanism and requires various
# classes and modules related to interacting with the Synsbasen API.
module SynsbasenApi
  # An array of required configuration keys.
  REQUIRED_CONFIGS = %i[api_key]

  # Configures the Synsbasen API client with the specified options.
  #
  # @yieldparam config [OpenStruct] The configuration object.
  def self.configure
    @config ||= OpenStruct.new
    yield(@config) if block_given?

    raise "Missing configuration. Required configurations are #{REQUIRED_CONFIGS}" unless REQUIRED_CONFIGS.all? { |c| @config[c] }

    @config
  end

  # Retrieves the current configuration or configures the Synsbasen API client with default options.
  #
  # @return [OpenStruct] The configuration object.
  def self.config
    @config || configure
  end
end
