require './lib/board'
require './lib/piece'
require './lib/pawn'
require './lib/rook'
require './lib/knight'
require './lib/bishop'
require './lib/queen'
require './lib/king'
require 'colorize'
# require 'pry'

wR1 = Rook.new([1,1], 'White')
wR2 = Rook.new([8,1], 'White')
wN1 = Knight.new([2,1], 'White')
wN2 = Knight.new([7,1], 'White')
wB1 = Bishop.new([3,1], 'White')
wB2 = Bishop.new([6,1], 'White')
wQ = Queen.new([4,1], 'White')
wK = King.new([5,1], 'White')
wP1 = Pawn.new([1,2], 'White')
wP2 = Pawn.new([2,2], 'White')
wP3 = Pawn.new([3,2], 'White')
wP4 = Pawn.new([4,2], 'White')
wP5 = Pawn.new([5,2], 'White')
wP6 = Pawn.new([6,2], 'White')
wP7 = Pawn.new([7,2], 'White')
wP8 = Pawn.new([8,2], 'White')

bR1 = Rook.new([1,8], 'Black')
bR2 = Rook.new([8,8], 'Black')
bN1 = Knight.new([2,8], 'Black')
bN2 = Knight.new([7,8], 'Black')
bB1 = Bishop.new([3,8], 'Black')
bB2 = Bishop.new([6,8], 'Black')
bQ = Queen.new([4,8], 'Black')
bK = King.new([5,8], 'Black')
bP1 = Pawn.new([1,7], 'Black')
bP2 = Pawn.new([2,7], 'Black')
bP3 = Pawn.new([3,7], 'Black')
bP4 = Pawn.new([4,7], 'Black')
bP5 = Pawn.new([5,7], 'Black')
bP6 = Pawn.new([6,7], 'Black')
bP7 = Pawn.new([7,7], 'Black')
bP8 = Pawn.new([8,7], 'Black')




pieces = [wB1, wB2, wR1, wR2, wP1, wP2, wP3, wP4, wP5, wP6, wP7, wP8, wN1, wN2, wQ, wK, bR1, bR2, bN1, bN2, bB1, bB2, bQ, bK, bP1, bP2, bP3, bP4, bP5, bP6, bP7, bP8]

chess_board = Board.new(pieces)
chess_board.play_game



