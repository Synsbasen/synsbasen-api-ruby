# frozen_string_literal: true

module SynsbasenApi
  class LeasingPeriod < Resource
    extend Searchable

    class << self
      private

      def resource_name
        "leasing_periods"
      end
    end
  end
end
