require "minitest/autorun"

require_relative "../lib/knights_travails"

describe KnightsTravails do
  it "catches invalid squares" do
    -> do
      KnightsTravails.find_path("a1", "NOT A SQUARE")
    end.must_raise(RuntimeError)

    -> do
      KnightsTravails.find_path("a1", "e1", "e1")
    end.must_raise(RuntimeError)
  end

  it "finds paths" do
    path = KnightsTravails.find_path("a8", "b7", "b6")
    path.to_s.must_equal("a8, c7, a6, c5, b7")
  end

  it "returns nil when a path cannot be found" do
    path = KnightsTravails.find_path("a8", "g6", "b6", "c7")
    path.must_be_nil
  end
end
