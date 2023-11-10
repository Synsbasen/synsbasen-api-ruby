module SynsbasenApi
  class Error < StandardError
    attr_accessor :message, :status, :data

    def initialize(msg = '', status = '', data = {})
      @message = msg
      @status = status
      @data = data
    end
  end

  class ClientError < Error; end

  class ServerError < Error; end
end
