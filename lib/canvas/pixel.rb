module Canvas
  class Pixel
    def initialize(rgb)
      @rgb = Array(rgb)
    end

    def to_a
      @rgb
    end

    def ==(other)
      to_a == other.to_a
    end

  end
end
