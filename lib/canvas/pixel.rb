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

    def self.rand
      new([
        rand(255),
        rand(255),
        rand(255)]
      )
    end
  end
end
