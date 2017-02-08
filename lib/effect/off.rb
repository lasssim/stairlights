module Effect
  class Off < Base
    
    attr_reader :color
    
    def initialize(printer:, opts:{})
      super
      @color = Canvas::Pixel.new([0, 0, 0])
    end

    def render_frame(time_elapsed:)
      canvas.each do |(x, y), pixel|
        canvas.set_pixel(x, y, color)
      end
      false
    end
  end
end
