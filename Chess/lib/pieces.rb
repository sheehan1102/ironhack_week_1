class ChessPiece
	attr_accessor :coordinates, :team, :name, :symbol

	def initialize(coordinates, team)
		@coordinates = coordinates
		@team = team
	end

	def pair_sort(pair, coordinate)
		sorted = pair.sort do |a, b|
			a[coordinate] <=> b[coordinate]
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

	def diagonal_path_builider(pair, step)
		path_array = []
		[*(pair[0][0] + 1)..pair[1][0]].each do |num|
			path_array << [num, pair[1][1] + step]
			step += step
		end	
		path_array
	end

	def diagonal_path(pair)
		slope = (pair[0][1] - pair[1][1])
		pair = pair_sort(pair, 0)
		if slope > 0
			path = diagonal_path_builider(pair, 1)
		else
			path = diagonal_path_builider(pair, -1)
		end
		p path
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

class Knight < ChessPiece
	def initialize(coordinates, team)
		super
		@name = 'Knight'
		@symbol = 'N'
	end

	def piece_logic(start, stop)
		if (start[0] - stop[0]).abs == 2 && (start[1] - stop[1]).abs == 1
			hash = [stop]
		elsif (start[0] - stop[0]).abs == 1 && (start[1] - stop[1]).abs == 2
			hash = [stop]
		else
			false		
		end
	end
end

class Bishop < ChessPiece
	def initialize(coordinates, team)
		super
		@name = 'Bishop'
		@symbol = 'B'
	end

	def piece_logic(start, stop)
		pair = [start, stop]
		if (start[0] - stop[0]).abs == (start[1] - stop[1]).abs
			diagonal_path(pair)
		else
			false
		end
	end
end















