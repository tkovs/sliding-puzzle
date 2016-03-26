require_relative 'game/sliding_puzzle'


print "Set the board size\n> "
size = gets
SlidingPuzzle.new(size.to_i).play
