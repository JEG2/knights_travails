module KnightsTravails
  class Path
    def initialize(*squares)
      @squares = squares
    end

    attr_reader :squares

    def include?(square)
      squares.include?(square)
    end

    def add_square(square)
      self.class.new(*squares, square)
    end

    def last
      squares.last
    end

    def to_s
      squares.join(", ")
    end
  end
end
