module Effect
  class Base
    include Celluloid

    attr_reader :printer, :canvas, :running, :logger, :fps

    def initialize(printer:, opts:{})
      @printer = printer
      @canvas  = printer.canvas
      @fps     = opts.fetch(:fps) { 25 }
      @running = false
      @logger  = ::Logger.new(STDOUT)
    end

    def start
      logger.debug "#{self.class}  start, running: #{running?}"
      running? || async.loop
    end

    def stop
      logger.debug "#{self.class}  stopping..."
      return unless running?
      @running = false
      wait(:loop_stopped)
      logger.debug "#{self.class}  stopped :)"

    end

    def render_frame(time_elapsed:)
      raise NotImplementedError
    end

    private

    def loop
      logger.debug "#{self.class}  loop start"
      @running = true
      begin
        while(running?) do
          lock_fps(fps) do |time_elapsed|
            @running = render_frame(time_elapsed: time_elapsed)
            logger.debug "#{self.class}  render_frame returned: #{@running.inspect}"
            printer.show
          end
        end
      rescue Exception => ex
        ap ex
        ap ex.backtrace
      ensure
        @running = false
        logger.debug "#{self.class}  sending loop_stopped signal"
        signal(:loop_stopped, nil)
      end
      logger.debug "#{self.class}  loop end"
    end

    def running?
      @running
    end

    def lock_fps(fps)
      time_per_frame = 1/fps.to_f
      start_time = Time.now.to_f

      yield(time_per_frame)

      end_time = Time.now.to_f

      time_elapsed = end_time - start_time
      time_to_wait = time_per_frame - time_elapsed

      sleep(time_to_wait)
    end
  end
end
