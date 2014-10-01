require "minitest/autorun"

require_relative "../lib/knights_travails/path_finder"
require_relative "../lib/knights_travails/square"

describe KnightsTravails::PathFinder do
  let(:start)   { KnightsTravails::Square.new("a1")      }
  let(:finish)  { KnightsTravails::Square.new("e1")      }
  let(:ignores) { %w[b3 c2].map(&KnightsTravails::Square.method(:new)) }
  let(:finder)  { KnightsTravails::PathFinder.new(start, finish) }

  it "starts with one path containing the start square only" do
    finder.paths.must_be_instance_of(Array)
    finder.paths.size.must_equal(1)
    finder.paths.first.to_s.must_equal("a1")
  end

  it "can generate new paths from existing paths" do
    finder.find_next
    finder.paths.map(&:to_s).sort.must_equal(["a1, b3", "a1, c2"])
  end

  it "doesn't double back" do
    2.times do
      finder.find_next
    end
    finder.paths.none? { |path| path.last == start }.must_equal(true)
  end

  it "will ignore specified squares" do
    finder = KnightsTravails::PathFinder.new(start, finish, ignores.first)
    finder.find_next
    finder.paths.map(&:to_s).sort.must_equal(["a1, c2"])
  end

  it "knows when it's out of moves" do
    finder = KnightsTravails::PathFinder.new(start, finish, *ignores)
    finder.find_next
    finder.done?.must_equal(true)
  end

  it "knows when it found a solution" do
    2.times do
      finder.find_next
    end
    finder.done?.must_equal(true)
  end

  it "finds paths" do
    solution = finder.find_solution
    solution.to_s.must_equal("a1, c2, e1")
  end
end
