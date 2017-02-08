module UseCase
  class LightStairs

    attr_reader :control_uuid, :logger
    def initialize(logger: config.logger)
      @control_uuid = "0d2956bb-02a8-1e74-ffffda868d47d75b" # PM Vorhaus EG
      @logger = logger

      logger.debug "Initialized LightStairs usecase"
    end
    

    def run
      logger.debug "LightStairs started"
      first_event = true

      #effect = Effect::RandomColor.new(printer: printer, opts: { time_till_change: 1 })
      effect = Effect::ProgressBar.new(printer: printer, logger: logger)

      effect_off = Effect::Off.new(printer: printer, logger: logger)
 
      logger.debug "Register Filter"
      
      event_filter.register_filter(uuid: control_uuid) do |event|

        
        logger.debug event.inspect

        begin
          effect.value = event.state.value

          value = event.state.value

          if value == 0
            effect.stop
            effect_off.start
          else
            effect_off.stop
            effect.start
          end
        rescue Exception => ex
          ap ex
          ap ex.backtrace
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
