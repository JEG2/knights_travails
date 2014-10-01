require "minitest/autorun"

require_relative "../lib/knights_travails/square"

describe KnightsTravails::Square do
  it "reads and write algebraic notation" do
    square = KnightsTravails::Square.new("a1")
    square.to_s.must_equal("a1")
  end

  it "knows if a square is valid" do
    square = KnightsTravails::Square.new("a1")
    square.valid?.must_equal(true)

    square = KnightsTravails::Square.new("a9")
    square.valid?.must_equal(false)
  end

  it "knows the next moves for a Knight" do
    square = KnightsTravails::Square.new("e4")
    moves  = square.knights_moves
    moves.must_be_instance_of(Array)
    moves.each do |move|
      move.must_be_instance_of(KnightsTravails::Square)
    end
    moves.map(&:to_s).sort.must_equal(%w[c3 c5 d2 d6 f2 f6 g3 g5])
  end

  it "doesn't generate invalid moves" do
    square = KnightsTravails::Square.new("g1")
    square.knights_moves.map(&:to_s).sort.must_equal(%w[e2 f3 h3])
  end

  it "ignore moves as specified" do
    square  = KnightsTravails::Square.new("g1")
    ignores = %w[e2 f3].map(&KnightsTravails::Square.method(:new))
    square.knights_moves(*ignores).map(&:to_s).sort.must_equal(%w[h3])
  end

  it "can compares themselves for equality" do
    KnightsTravails::Square.new("a1").must_equal(
      KnightsTravails::Square.new("a1")
    )
  end
end
