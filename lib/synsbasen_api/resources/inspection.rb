# frozen_string_literal: true

module SynsbasenApi
  # The `Inspection` class provides methods for interacting with inspection-related
  # endpoints in the Synsbasen API.
  class Inspection < Resource
    extend Findable
    extend Searchable

    class << self
      private

      def resource_name
        "inspections"
      end
    end
  end
end
