module Canvas

  class Base
    include Enumerable

    attr_reader :default_pixel, :pixels
    
    def initialize(opts:{})
      @default_pixel = opts.fetch(:default_pixel) { Pixel.new([0, 0, 0]) }
      @pixels = Hash[pixel_coordinates.map { |pc| [pc, default_pixel] }]
    end

    def pixels=(new_pixels)
      valid_new_pixels = new_pixels.select { |k| pixels.has_key? k }
      @pixels.merge!(valid_new_pixels)
    end


    def set_pixel(x, y, pixel)
      self.pixels = { [x, y] => pixel }
    end

    def each(&block)
      pixels.each do |pixel|
        block.call(pixel)
      end
    end

    # TODO: extract serialize and deserialize to separate classes
    def serialize
      MessagePack.pack(serializable_hash)
    end
  
    def deserialize(hash)
      self.pixels = hash.merge(hash) do |_, v|
        Pixel.new(v)
      end
    end
  
    def ==(other)
      pixels == other.pixels
    end

    def serializable_hash
      pixels.merge(pixels) do |_, v|
        v.to_a
      end
 
    end

    private

    def pixel_coordinates
      raise NotImplementedError
    end
 
  end
end
