# frozen_string_literal: true

module SynsbasenApi
  class Resource < Client
    class << self
      private

      # Define the resource name
      #
      # @return [String]
      # @raise [NotImplementedError] if the method is not implemented by the subclass
      def resource_name
        raise NotImplementedError, 'Subclasses must implement this method'
      end
    end
  end
end
