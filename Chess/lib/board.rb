class Board
	attr_accessor :board
	LOOK_UP = [
			['a', 1],
			['b', 2],
			['c', 3],
			['d', 4],
			['e', 5],
			['f', 6],
			['g', 7],
			['h', 8]
		]

	def initialize(pieces)
		@pieces = pieces
		@board = []
	end

	def initialize_board
		row = (0..8).to_a
		for i in 1..8
			@board[i] = row
		end
	end

	def instructions
		puts "The pieces are: king, queen, bishop, knight, rook, pawn. Type the the origin then the destination: b6 to b4. Type 'i' for instructions, 'q' to quit."
	end

	def draw_board
		array = [*1..8].reverse
		array.each do |num|
			[*1..8].each do |x|
				square = [x, num]
				piece = piece_presence(square)
				if piece && piece.team == 'White'
					print piece.symbol.colorize(:color => :white, :background => :blue) + " "
				elsif piece
					print piece.symbol.colorize(:color => :light_black, :background => :green) + " "
				else
					print '+ '
				end
			end
			print "\n"
		end
	end

	def library(coordinates)
		x = coordinates[0]
		LOOK_UP.each do |pair|
			if pair[0] == x
				x = pair[1]
			end
		end
		y = coordinates[1].to_i
		[x,y]
	end

	def piece_presence(coordinates)
		piece = @pieces.find do |piece|
			piece.coordinates == coordinates
		end
		piece
	end

	def look_up_position(query)
		origin = query[0..1]
		destination = query[-2..-1]
		origin = library(origin)
		destination = library(destination)
		move_piece(origin, destination)
	end

	def check_path(path)
		conflict = path.find do |square|
			piece_presence(square)
		end
		conflict
	end

	def check_for_static_move(origin, destination)
		origin == destination
	end

	def move_piece(origin, destination)
		piece = piece_presence(origin)
		if piece
			if !check_for_static_move
				path = piece.piece_logic(origin, destination)
				if path
					if !check_path(path)
						piece.coordinates = destination
						puts "Good move"
					else
						puts "There is a piece in your way."
					end
				else
					puts "You can't make that move with a #{piece.name}"
				end
			else
				"You did not make a move."
			end
		else
			puts "There is no piece in that square."
		end
	end

	def game_logic(query)
		if query == 'i'
			instructions
		elsif query == 'q'
			exit
		elsif query.include?(' to ')
			look_up_position(query)	
		else
			"I don't understand"	
		end
	end

	def play_game
		puts ''
		puts "Welcome to Chess:".underline
		puts ''
		instructions
		@gameplay = true
		while @gameplay
			draw_board
			game_logic(gets.chomp.downcase)
		end
	end
end