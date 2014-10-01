require_relative "path"

module KnightsTravails
  class PathFinder
    def initialize(start, finish, *ignored)
      @paths    = [Path.new(start)]
      @goal     = finish
      @ignored  = ignored
      @solution = nil
    end

    attr_reader :paths, :goal, :ignored

    def solution
      @solution ||= paths.find { |path| path.last == goal }
    end

    def find_next
      @paths = paths.flat_map { |path|
        path
          .last
          .knights_moves(*path.squares, *ignored)
          .map { |move| path.add_square(move) }
      }
    end

    def done?
      !!(paths.empty? || solution)
    end

    def find_solution
      find_next until done?
      solution
    end
  end
end
