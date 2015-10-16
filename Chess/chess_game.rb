require './lib/board'
require './lib/pieces'
require 'colorize'
# require 'pry'

wR1 = Rook.new([1,1], 'White')
wR2 = Rook.new([8,1], 'White')

wP1 = Pawn.new([1,2], 'White')
wP2 = Pawn.new([2,2], 'White')
wP3 = Pawn.new([3,2], 'White')
wP4 = Pawn.new([4,2], 'White')
wP5 = Pawn.new([5,2], 'White')
wP6 = Pawn.new([6,2], 'White')
wP7 = Pawn.new([7,2], 'White')
wP8 = Pawn.new([8,2], 'White')


pieces = [wR1, wR2, wP1, wP2, wP3, wP4, wP5, wP6, wP7, wP8]

chess_board = Board.new(pieces)
chess_board.initialize_board

chess_board.play_game



