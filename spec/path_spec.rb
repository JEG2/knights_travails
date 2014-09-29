require "minitest/autorun"

require_relative "../lib/knights_travails/path"

describe KnightsTravails::Path do
  let(:path) { KnightsTravails::Path.new("a1") }

  it "knows if it includes a Square" do
    path.include?("a1").must_equal(true)
    path.include?("b1").must_equal(false)
  end

  it "it can add a Square to build a new Path" do
    new_path = path.add_square("c2")
    path.squares.must_equal(%w[a1])
    new_path.squares.must_equal(%w[a1 c2])
  end
end
