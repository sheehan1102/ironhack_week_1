class ChessPiece
	attr_accessor :coordinates, :team, :name, :symbol

	def initialize(coordinates, team)
		@coordinates = coordinates
		@team = team
	end

	def pair_sort(pair, coordinate)
		sorted = pair.sort_by do |a, b|
			b[coordinate] <=> a[coordinate]
		end
		sorted
	end

	def vertical_path(pair)
		pair = pair_sort(pair, 1)
		path_array = []
		[*(pair[0][1] + 1)..pair[1][1]].each do |num|
			path_array << [pair[0][0], num]
		end
		path_array
	end

	def horizontal_path(pair)
		pair = pair_sort(pair, 0)
		path_array = []
		[*(pair[0][0] + 1)..pair[1][0]].each do |num|
			path_array << [num, pair[0][1]]
		end
		path_array
	end
end

class Pawn < ChessPiece
	def initialize(coordinates, team)
		super
		@name = 'Pawn'
		@symbol = 'P'
		@first_move = true
	end

	def piece_logic(start, stop)
		pair = [start, stop]
		if start[0] == stop[0] && (start[1] - stop[1]).abs < 3 && @first_move
			@first_move = false
			vertical_path(pair)
		elsif start[0] == stop[0] && (start[1] - stop[1]).abs < 2
			vertical_path(pair)
		else
			false
		end
	end
end

class Rook < ChessPiece
	def initialize(coordinates, team)
		super
		@name = 'Rook'
		@symbol = 'R'
	end

	def piece_logic(start, stop)
		pair = [start, stop]
		if start[0] == stop[0]
			vertical_path(pair)
		elsif start[1] == stop[1]
			horizontal_path(pair)
		else
			false
		end
	end
end

















