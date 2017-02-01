module Effect
  class SingleColor < Base
    
    attr_reader :color
    
    def initialize(printer:, opts:)
      super
      @color = opts.fetch(:pixel)
    end

    def render_frame(opts)
      @frame ||= begin
        canvas.each do |(x, y), pixel|
          canvas.set_pixel(x, y, color)
        end
      end
    end
  end
end
