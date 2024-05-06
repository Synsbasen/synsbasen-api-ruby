# frozen_string_literal: true

module SynsbasenApi
  class Resource < Client
    class << self
      private

      def resource_name
        raise NotImplementedError, 'Subclasses must implement this method'
      end
    end
  end
end
