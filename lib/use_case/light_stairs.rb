module UseCase
  class LightStairs

    attr_reader :control_uuid, :logger
    def initialize(logger: config.logger)
      @control_uuid = "0d2956bb-02a8-1e74-ffffda868d47d75b" # PM Vorhaus EG
      @logger = logger
    end
    

    def run
      first_event = true

      #effect = Effect::RandomColor.new(printer: printer, opts: { time_till_change: 1 })
      effect = Effect::ProgressBar.new(printer: printer)
      effect_future = nil

      color = Canvas::Pixel.new([0, 0, 0])
      effect_off = Effect::SingleColor.new(printer: printer, opts: { pixel: color })
 
      value = nil

      event_filter.register_filter(uuid: control_uuid) do |event|

        value = event.state.value
        
        opts = { 
          value: value
        }
       
        logger.debug event.inspect

        raise "This memoization doesn't allow the value to be updated in the loop."
        effect_future ||= begin 
          p_r = Proc.new { [value != 0, opts] }
          effect.future.loop(p_r)
        end

        if value == 0
          effect_future.value
          p_s = Proc.new { [value == 0, opts] }
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
      @canvas ||= config.canvas_class.new(
        opts: config.canvas_opts || {}
      )
    end

    def printer
      @printer ||= config.printer_class.new(
        canvas: canvas,
        logger: UseCase.config.logger,
        opts: config.printer_opts || {}
      )
    end

    def config
      UseCase.config 
    end
  end
end
