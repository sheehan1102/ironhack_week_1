class ChessPiece
	attr_accessor :coordinates

	def initialize(coordinates)
		@coordinates = coordinates
	end
end

class Rook < ChessPiece
	def initialize(coordinates)
		super
	end

	def piece_logic(start, stop)
		true
	end
end