module UseCase
  class LighStairs

    attr_reader :control_uuid
    def initialize
      @control_uuid = "0d2956bb-02a8-1e74-ffffda868d47d75b" # PM Vorhaus EG
    end
    

    def run
      first_event = true

      effect = Effect::RandomColor.new(printer: printer, opts: { time_till_change: 1 })
      effect_future = nil

      color = Canvas::Pixel.new([0, 0, 0])
      effect_off = Effect::SingleColor.new(printer: printer, opts: { pixel: color })
 
      value = nil

      event_filter.register_filter(uuid: control_uuid) do |event|

        value = event.state.value
        puts event.inspect

        effect_future ||= begin 
          p_r = Proc.new { [value != 0, nil] }
          effect.future.loop(p_r)
        end

        puts effect_future.ready?
        if value == 0
          effect_future.value
          p_s = Proc.new { [value == 0, nil] }
          effect_off.async.loop(p_s)
          effect_future = nil
        end
        
      end
      
      loxone_connection

      while true; sleep; end
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
