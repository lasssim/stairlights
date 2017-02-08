module Effect
  class ProgressBar < Base
    
    attr_reader :max_value

    def initialize(printer:, opts:{})
      super
      @max_value = 0
    end

    def render_frame(time_elapsed:)
      bright = Canvas::Pixel.new([255, 214, 170])
      dark   = Canvas::Pixel.new([100, 100, 100])

      progress = progress(value)

      canvas.each do |(x, y), pixel|
        color = if y < progress
          bright
        else
          dark
        end

        canvas.set_pixel(x, y, color)
      end
      true
    end

    private

    def progress(value)
      @max_value = [max_value, value].max
      
      height = printer.canvas.height

#      ap "...."
#      ap value
#      ap max_value
#      ap height
#      ap value/max_value
#      ap value/max_value * height
      value/max_value * height
    end

  end
end
