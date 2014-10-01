module KnightsTravails
  class Square
    def initialize(algebraic_notation)
      @algebraic_notation = algebraic_notation
    end

    attr_reader  :algebraic_notation
    alias_method :to_s, :algebraic_notation

    def valid?(*ignored_moves)
      !!(algebraic_notation =~ /\A[a-h][1-8]\z/) &&
      !ignored_moves.include?(self)
    end

    def knights_moves(*ignored_moves)
      fail "Invalid square" unless valid?

      col   = algebraic_notation[0].ord
      row   = algebraic_notation[1].to_i
      moves = [ ]
      (-2..2).each do |col_offset|
        (-2..2).each do |row_offset|
          next if col_offset.zero? || row_offset.zero?
          next if col_offset.abs == row_offset.abs

          move   = self.class.new("#{(col + col_offset).chr}#{row + row_offset}")
          moves << move if move.valid?(*ignored_moves)
        end
      end
      moves
    end

    def ==(other)
      algebraic_notation == other.algebraic_notation
    end
  end
end
