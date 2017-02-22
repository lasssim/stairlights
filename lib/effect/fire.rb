module Effect
  class Fire < Base
    
    attr_reader :fire_color, :off

    def initialize(printer:, logger:, opts:{})
      super
      @fire_color = Canvas::Pixel.new([226, 88, 34]) 
      @off        = Canvas::Pixel.new([0, 0, 0])
    end

    def render_frame(time_elapsed:)
      canvas.each do |(x, y), pixel|
        canvas.set_pixel(x, y, off)
        add_color(x, y, fire_color)

        r = rand(200)
        diff_color = Canvas::Pixel.new([r, r/2, r/2])

        substract_color(x, y, diff_color)
      end
    end

    private

    def add_color(x, y, color)
      blended_color = blend(canvas.pixels[[x,y]], color)
      canvas.set_pixel(x, y, blended_color)
    end

    def substract_color(x, y, color)
      blended_color = substract(canvas.pixels[[x,y]], color)
      canvas.set_pixel(x, y, blended_color)
    end

    def blend(color1, color2)
      color_a = [color1.to_a, color2.to_a].transpose.map { |x| clamp(x.reduce(:+)) }
      Canvas::Pixel.new(color_a)
    end

    def substract(color1, color2)
      color_a = [color1.to_a, color2.to_a].transpose.map { |x| clamp(x.reduce(:-)) }
      Canvas::Pixel.new(color_a)
    end

    def clamp(value, min:0, max:255)
      value < min ? min : value > max ? max : value
    end

  end
end
