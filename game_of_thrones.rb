module FindRoom
	def find_room(world, index)
		room = world.rooms.find { |room| room.index == index }
	end
end

class ParseQuery
	def parse_query(query)
		if query.include?('pick up ')
			query = query[8..query.length]
		end
		query
	end
end

class Engine
	include FindRoom

	def initialize(movement, queries, player)
		@movement = movement
		@queries = queries
		@player = player
	end

	def start_game(starting_room)
		puts ' '
		puts '****-----------'
		puts '*'
		puts '*'
		puts '*   Welcome to THE DARKWOODS BOARDING HOUSE....'
		puts '*'
		puts '*'
		puts '****-----------'
		puts ' '
		puts starting_room.description
		print '> '
		interpret(starting_room, @player, gets.chomp.downcase)
	end

	def find_query(player_query)
		@queries.find { |query| player_query == query.indicator }
	end

	def run_loop(new_room, player)
		interpret(new_room, player, gets.chomp.downcase)
	end

	def interpret(room, player, player_query)
		query = ParseQuery.new.parse_query(player_query)
		result = find_query(query)
		if result
			index = result.make_move(@movement, room)
			new_room = find_room(@movement.world, index)
			run_loop(new_room, player)
		else
			puts "I don't understand."
			run_loop(room, player)
		end
	end
end

class World
	attr_accessor :rooms

	def initialize
		@rooms = []
	end
end

class Room
	attr_reader :index, :description, :directions
	attr_accessor :items

	def initialize(index, description, directions, items = [])
		@index = index
		@description = description
		@directions = directions
		@directions = {
			north: directions[0],
			south: directions[1],
			east: directions[2],
			west: directions[3]
		}
		@items = items
	end
end

class Item
	attr_reader :description, :true_name, :names, :pick_up_text

	def initialize(description, true_name, names, pick_up_text)
		@description = description
		@true_name = true_name
		@names = names
		@pick_up_text = pick_up_text
	end
end

class Player
	attr_accessor :items, :current_index

	def initialize(current_index = nil)
		@items = []
	end
end

class Movement
	include FindRoom
	attr_reader :world

	def initialize(world)
		@world = world
	end

	def change_room(index, move_description = "I don't understand")
		room = find_room(@world, index)
		puts ' '
		puts move_description
		tell_about_items(room)
		print '> '
		return index
	end

	def tell_about_items(room)
		if room.items.size > 0
			item_text = room.items.reduce('') do |sum, item|
				sum + " #{item.description} "
			end
			puts "#{room.description}#{item_text}"
		else
			puts room.description
		end
	end
end



# class Intelligence
# 	def initialize(movement)
# 		@movement = movement
# 	end

# 	def interpret(room, query, player)
# 		if query == 'quit'
# 			exit
# 		elsif query == 'i'
# 			puts ' '
# 			puts 'Your items:'.underline
# 			player.items.each do |item|
# 				puts item.true_name
# 			end
# 			@movement.change_room(room.index, '')
# 		elsif query == 'n'
# 			if room.directions[:north][1]
# 				@movement.change_room(room.directions[:north][2], room.directions[:north][0])
# 			else
# 				@movement.change_room(room.index, room.directions[:north][0])
# 			end
# 		elsif query == 's'
# 			if room.directions[:south][1]
# 				@movement.change_room(room.directions[:south][2], room.directions[:south][0])
# 			else
# 				@movement.change_room(room.index, room.directions[:south][0])
# 			end
# 		elsif query == 'e'
# 			if room.directions[:east][1]
# 				@movement.change_room(room.directions[:east][2], room.directions[:east][0])
# 			else
# 				@movement.change_room(room.index, room.directions[:east][0])
# 			end
# 		elsif query == 'w'
# 			if room.directions[:west][1]
# 				@movement.change_room(room.directions[:west][2], room.directions[:west][0])
# 			else
# 				@movement.change_room(room.index, room.directions[:west][0])
# 			end
# 		elsif query.include?('pick up ')
# 			query = query[8..query.length]
# 			if room.items.size > 0
# 				item_to_pick_up = nil
# 				room.items.each do |item|
# 					presence = item.names.find do |name|
# 						name == query
# 					end
# 					if presence
# 						item_to_pick_up = item
# 					end
# 				end
# 				if !item_to_pick_up.nil?
# 					player.items << item_to_pick_up
# 					room.items.delete(item_to_pick_up)
# 					@movement.change_room(room.index, item_to_pick_up.pick_up_text)
# 				else
# 					@movement.change_room(room.index, "I don't understand.")
# 				end
# 			end
# 			@movement.change_room(room.index)
# 		else
# 			@movement.change_room(room.index, "You can't do that.")
# 		end
# 	end
# end

class Query
	attr_reader :indicator

	def initialize
		@indicator = indicator
	end
end

class Quit < Query
	def initialize
		@indicator = 'quit'
	end

	def make_move
		exit
	end
end

class North < Query
	def initialize
		@indicator = 'n'
	end

	def make_move(movement, room)
		if room.directions[:north][1]
			movement.change_room(room.directions[:north][2], room.directions[:north][0])
		else
			movement.change_room(room.index, room.directions[:north][0])
		end
	end
end

class South < Query
	def initialize
		@indicator = 's'
	end

	def make_move(movement, room)
		if room.directions[:south][1]
			movement.change_room(room.directions[:south][2], room.directions[:south][0])
		else
			movement.change_room(room.index, room.directions[:south][0])
		end
	end
end

class East < Query
	def initialize
		@indicator = 'e'
	end

	def make_move(movement, room)
		if room.directions[:east][1]
			movement.change_room(room.directions[:east][2], room.directions[:east][0])
		else
			movement.change_room(room.index, room.directions[:east][0])
		end
	end
end

class West < Query
	def initialize
		@indicator = 'w'
	end

	def make_move(movement, room)
		if room.directions[:west][1]
			movement.change_room(room.directions[:west][2], room.directions[:west][0])
		else
			movement.change_room(room.index, room.directions[:west][0])
		end
	end
end

class PickUp < Query

end

world = World.new

room_A1 = Room.new('A1', "You are standing on a grass lawn. In front of you, there is a short, rusty staircase. Behind you, there is forest.", [
		['There is dense forest', false],
		['You go up the stairs.', true, 'A2'],
		['There is dense forest', false],
		['There is dense forest', false]
	]
)
world.rooms << room_A1

room_A2 = Room.new('A2', "You are on a rickety porch that wraps around a tall, narrow, wood clapboarded building. There is a door in front of you.", [
		['You go back down the stairs', true, 'A1'],
		['You open the door and go into the house', true, 'A5'],
		['You walk around the porch.', true, 'A4'],
		['You walk around the porch.', true, 'A3']
	]
)
world.rooms << room_A2

room_A3 = Room.new('A3', "You are at a corner of the porch. To the south the porch follows the house.", [
		["The railing is too high to jump over.", false],
		["You continue down the porch", true, 'A6'],
		["Heading back toward the door.", true, 'A2'],
		["The railing is too high to jump over.", false]
	]
)
world.rooms << room_A3

room_A4 = Room.new('A4', "You are at a corner of the porch. To the south the porch follows the house.", [
		["The railing is too high to jump over.", false],
		["You continue down the porch", true, 'A7'],
		["The railing is too high to jump over.", false],
		["Heading back toward the door.", true, 'A2']
	]
)
world.rooms << room_A4

room_A5 = Room.new('A5', "You are in a room with a six small tables that are strewn about. There are cobwebs under the tables and many of the chairs have broken legs.", [
		["Yeah, let's get out of here!", true, 'A2'],
		["There is in alcove in the back", true, 'A8'],
		["The wall is filled with strange crayon drawings in reds, blues, greens and blacks.", false],
		["Yes, look out the window. It's good to see real light again.", false]
	],
	[
		Item.new("You sniff it first, then notice a dead bat.", 'Dead bat', ['bat', 'dead bat'], "Cool. You have a dead bat. Great."),
		Item.new("Under an age of dust, there is a mason jar.", 'Dusty mason jar', ['dusty mason jar', 'mason jar', 'jar'], "You picked up the dusty mason jar!")
	]
)
world.rooms << room_A5

room_A6 = Room.new('A6', "The wrap around porch abruptly ends. On the house, there is dark window.", [
		["You head back toward the corner of the porch.", true, 'A3'],
		["The railing is too high to jump over.", false],
		["Through the window, you see tables and chairs in disarray.", false],
		["The railing is too high to jump over.", false],
	]
)
world.rooms << room_A6

room_A7 = Room.new('A7', "The wrap around porch ends abruptly. On the wall of the builiding, many of the clapboards are pealing, and a few look ready to fall from the wall.", [
		["You head back toward the corner of the porch", true, 'A4'],
		["The railing is too high to jump over.", false],
		["The railing is too high to jump over.", false],
		["The pealing paint is beautiful from up close.", false]
	]
)
world.rooms << room_A7


queries = [North.new, South.new, East.new, West.new, Quit.new]
player = Player.new

Engine.new(Movement.new(world), queries, player).start_game(room_A1)








