require_relative "knights_travails/square"
require_relative "knights_travails/path_finder"

module KnightsTravails
  def self.find_path(start, finish, *ignored)
    ignored       = ignored.map(&KnightsTravails::Square.method(:new))
    start, finish = [start, finish].map(&KnightsTravails::Square.method(:new))

    fail "Invalid squares" unless ignored.all?(&:valid?) &&
                                  start.valid?(*ignored) &&
                                  finish.valid?(*ignored)

    KnightsTravails::PathFinder.new(start, finish, *ignored).find_solution
  end
end
