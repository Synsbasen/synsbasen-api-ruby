require "synsbasen_api/client"
require "synsbasen_api/resources/brand"
require "synsbasen_api/resources/inspection"
require "synsbasen_api/resources/inspection_test_center"
require "synsbasen_api/resources/model"
require "synsbasen_api/resources/test_center"
require "synsbasen_api/resources/vehicle"
require "synsbasen_api/resources/variant"
require "synsbasen_api/resources/version"

module SynsbasenApi
  REQUIRED_CONFIGS = %i[api_key]

  def self.configure
    @config ||= OpenStruct.new
    yield(@config) if block_given?

    raise "Missing configuration. Required configurations are #{REQUIRED_CONFIGS}" unless REQUIRED_CONFIGS.all? { |c| @config[c] }

    @config
  end

  def self.config
    @config || configure
  end
end
