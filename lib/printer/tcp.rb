require 'set'
module Printer

  class TCP < Base

    attr_reader :hostname

    def initialize(canvas:, logger:, opts:{})
      super
      @hostname = opts.fetch(:hostname)
    end


    def show
      logger.debug "#{self.class}  sent: #{canvas.to_a.to_set.hash}"
      socket.puts canvas.serialize
    end


    private

    def socket
		  @socket ||= TCPSocket.open(hostname, 3030)
    end

  end
end
