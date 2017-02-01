module Effect
  class Base
    include Celluloid

    attr_reader :printer, :canvas
    
    def initialize(printer:, opts:)
      @printer = printer
      @canvas  = printer.canvas
      @fps     = opts.fetch(:fps) { 60 }
    end

    def loop(p)
      run = true 
      while(run) do
        lock_fps(60) do |time_elapsed|
          run, opts = p.call
         
          opts ||= {}
          opts.merge!(time_elapsed: time_elapsed)
          render_frame(opts)
        
          printer.show
        end
      end

    end


    def render_frame(opts)
      raise NotImplementedError
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
