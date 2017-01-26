module Canvas
  class Rectangle < Base
    attr_reader :width, :height
    
    def initialize(opts:{})
      @width  = opts.fetch(:width)
      @height = opts.fetch(:height)
      super
    end
 
    def pixels
      @pixels ||= begin
        Hash[pixel_coordinates.map { |pc| [pc, default_pixel] }]
      end
    end
  
 
    private
    def pixel_coordinates
      x_indexes = (0...width).to_a
      y_indexes = (0...height).to_a
      pixel_coordinates = x_indexes.product(y_indexes)
    end
   
  end
end
