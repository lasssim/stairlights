require 'sdl'

module Printer

  class SDL < Base

    attr_reader :pixel_width, :pixel_height, :columns_space, :pixels_space

    def initialize(canvas:, logger:, opts:{})
      super
      @pixel_width = 4 
      @pixel_height = 4 
      @columns_space = 5
      @pixels_space = 1
      ::SDL.init ::SDL::INIT_VIDEO
      show
    end


    def show
      canvas.pixels.each do |(x, y), pixel|
        color = screen.mapRGB(*pixel.to_a)
        x_rect = (pixel_height + columns_space) * x
        y_rect = (pixel_width + pixels_space) * y
        screen.fillRect(x_rect, y_rect, pixel_width, pixel_height, color)
      end
          
      screen.updateRect 0,0,0,0
    end


    private
    def screen
      @screen ||= begin
        screen_width          = (pixel_width + columns_space) * canvas.width
        screen_height         = (pixel_height + pixels_space) * canvas.height
        screen_bits_per_pixel = 24
        ::SDL::setVideoMode(
          screen_width,
          screen_height,
          screen_bits_per_pixel, 
          ::SDL::SWSURFACE | ::SDL::ANYFORMAT
        )
      end
    end



  end
end
