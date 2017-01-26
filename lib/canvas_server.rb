require 'celluloid/io'

class CanvasServer
  include Celluloid::IO
  finalizer :shutdown

  attr_reader :host, :port, :printer, :logger

  def initialize(host: "localhost", port: 3030, printer:, logger: Logger.new(STDOUT))
    @host    = host
    @port    = port
    @printer = printer
    @logger  = logger
  end

  def start
    async.run
  end

  def stop
    server.close
  end

  private

  def run
    printer.startup_animation
    loop do
      async.handle_connection(server.accept)
    end
#  rescue Exception => ex
#    ap ex
#    ap ex.backtrace
#    binding.pry
#    raise ex
  end

  def handle_connection(socket)
    logger.info "new connection"
    unpacker = MessagePack::Unpacker.new
    socket.each_line do |message|
      logger.debug "received frame"
      frame_message = message

      unpacker.feed_each(frame_message) do |frame|
        next unless frame. instance_of? Hash
        printer.canvas.deserialize(frame)
        logger.debug "calling printer"
        printer.show
      end
    end
    socket.close
  end

  def server
    @server ||= begin
      logger.info "Starting server on <#{host}:#{port}>"
      TCPServer.new(host, port)
    end
  end

  def receive_frame_message(socket)
    
  end
end
