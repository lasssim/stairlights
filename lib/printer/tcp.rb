
module Printer

  class TCP < Base

    attr_reader :hostname

    def initialize(canvas:, logger:, opts:{})
      super
      @hostname = opts.fetch(:hostname)
    end


    def show
      socket.puts canvas.serialize
    end


    private

    def socket
		  @socket ||= TCPSocket.open(hostname, 3030)
    end

  end
end
