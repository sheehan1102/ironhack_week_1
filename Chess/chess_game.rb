require './lib/board'
require './lib/pieces'
require 'colorize'
require 'pry'

bR1 = Rook.new([1,1])

pieces = [bR1]

chess_board = Board.new(pieces)
chess_board.initialize_board

chess_board.play_game



