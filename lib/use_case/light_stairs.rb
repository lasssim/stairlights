module UseCase
  class LighStairs

    attr_reader :control_uuid
    def initialize
      @control_uuid = "0e745744-02ca-4d7e-fffffc9dca063474" # Pudl Licht
    end
    

    def run
      event_filter.register_filter(uuid: control_uuid) do |event|
        
        color = if event.state.value != 0
          [rand(255), rand(255), rand(255)]
        else
          [0, 0, 0]  
        end
        
        new_pixel = Canvas::Pixel.new(color)
        canvas.pixels = Hash[canvas.pixels.map do |(x, y), pixel|
          [[x, y], new_pixel]
        end]
       
      
        printer.show

      end
      loxone_connection
    end

    private

    def event_filter
      @event_filter ||= Loxone::MessageHandler::EventFilter.new
    end

    def loxone_connection
      @loxone_connection ||= Loxone::Connection.new(message_handler: event_filter)
    end

    def canvas
      @canvas ||= Canvas::Rectangle.new(
        opts: {
          width: 2,
          height: 200
        }
      )
    end

    def printer
      Printer::SDL.new(canvas: canvas, logger: Logger.new(nil), opts: {})
    end


  end
end
