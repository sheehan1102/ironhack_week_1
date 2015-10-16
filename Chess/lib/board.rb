class Board
	attr_accessor :board, :move_counter
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
		@move_counter = 1
		@piece = nil
	end

	def instructions
		puts "The pieces are: king, queen, bishop, knight, rook, pawn. Type the the origin then the destination: b6 to b4. Type 'i' for instructions, 'q' to quit.\n"
	end

	def blocking_piece
		puts "There is a piece in your way."
	end

	def piece_misuse(piece)
		puts "You can't make that move with a #{piece.name}"
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
					print piece.symbol.colorize(:color => :red, :background => :green) + " "
				else
					print '+ '
				end
			end
			print "\n"
		end
		print "\n"
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

	def check_path(path, destination)
		path.delete(destination)
		conflict = path.find do |square|
			piece_presence(square)
		end
		conflict
	end

	def check_for_static_move(origin, destination)
		origin == destination
	end

	def make_kill(piece, target, destination)
		target.kill_piece
		finish_move(piece, destination)
		puts "You took the enemy #{waiting_piece.name}!"
	end

	def look_for_kill(destination, moving_piece)
		waiting_piece = piece_presence(destination)
		if waiting_piece && waiting_piece.team != moving_piece.team
			make_kill(moving_piece, waiting_piece, destination)
		elsif waiting_piece
			blocking_piece
		else
			finish_move(moving_piece, destination)
			puts "You made a move."
		end
	end

	def pawn_logic(piece, origin, destination)
		target = piece_presence(destination)
		if target && target.team != piece.team
			if piece.kill_logic(origin, destination)
				make_kill(piece, target, destination)
			end
		elsif target	
			piece_misuse(piece)
		end
		piece.piece_logic(origin, destination)
	end

	def finish_move(piece, destination)
		piece.coordinates = destination
		@move_counter += 1
	end

	def move_piece(origin, destination)
		@piece = piece_presence(origin) # here
		if piece
			if !check_for_static_move(origin, destination)
				if piece.class != Pawn
					pawn_logic(piece, origin, destination)
				end
				path = piece.piece_logic(origin, destination)
				if path
					if !check_path(path, destination)
						look_for_kill(destination, piece)
					else
						blocking_piece
					end
				else
					piece_misuse(piece)
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
		elsif query.include?(' to ') && query.size == 8
			look_up_position(query)	
		else
			puts "I don't understand"	
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
			print '> '
			game_logic(gets.chomp.downcase)
		end
	end
end