module Effect
  class RandomColor < Base
    
    attr_reader :time_till_change
    attr_accessor :time_since_last_color_change
    
    def initialize(printer:, opts:)
      super
      @time_till_change = opts.fetch(:time_till_change)
      reset_time_since_last_color_change
    end

    def render_frame(opts)
      inc_time_since_last_color_change_by(opts.fetch(:time_elapsed))
      
      return unless render_new_frame?

      color = Canvas::Pixel.new([rand(255), rand(255), rand(255)])
      canvas.each do |(x, y), pixel|
        canvas.set_pixel(x, y, color)
      end
      
      reset_time_since_last_color_change
    end

    private

    def inc_time_since_last_color_change_by(time)
      self.time_since_last_color_change += time
    end

    def reset_time_since_last_color_change
      self.time_since_last_color_change = 0
    end

    def render_new_frame?
      time_since_last_color_change >= time_till_change
    end

  end
end
