require 'date'

class ShoppingCart
	attr_reader :cart

	def initialize
		@cart = []
	end

	def add_item_to_cart(item)
		@cart << item
	end

	def find_discounts
		apple_discount
		orange_discount
		grape_discount
	end

	def apple_discount
		total_apples = @cart.select { |item| item.class == Apple }
		if total_apples.size > 1
			puts "You get two apples for the price of one!"
		end
	end

	def orange_discount
		total_oranges = @cart.select { |item| item.class == Orange }
		if total_oranges.size > 2
			puts "You get three of those apples for the price of two!"
		end
	end

	def grape_discount
		total_grapes = @cart.select { |item| item.class == Grape }
		if total_grapes.size > 3
			puts "With those four grapes, you get a free banana!"
		end
	end
end

class Item
	def month_pricing
		month = Time.now.strftime('%-d').to_i
		if month == 12 || month <= 2
			@price[:winter]
		elsif month >= 3 && month <= 5
			@price[:spring]
		elsif month >= 6 && month <= 8
			@price[:summer]
		else
			@price[:autumn]
		end
	end

	def price
		month_pricing
	end

end

class Apple < Item
	def initialize
		@price = {
			spring: 10,
			summer: 10,
			autumn: 15,
			winter: 12
		}
	end
end

class Orange < Item
	def initialize
		@price = {
			spring: 5,
			summer: 2,
			autumn: 5,
			winter: 5
		}
	end
end

class Grape < Item
	def initialize
		@price = {
			spring: 15,
			summer: 15,
			autumn: 15,
			winter: 15
		}
	end
end

class Banana < Item
	def initialize
		@price = {
			spring: 20,
			summer: 20,
			autumn: 20,
			winter: 21
		}
	end
end

class Watermelon < Item
	def initialize
		@price = {
			spring: 50,
			summer: 50,
			autumn: 50,
			winter: 50
		}
	end

	def price
		if Time.now.strftime("%u").to_i == 7
			(super * 2)
		else
			super
		end
	end
end

cart = ShoppingCart.new

cart.add_item_to_cart(Grape.new)
cart.add_item_to_cart(Grape.new)
cart.add_item_to_cart(Grape.new)
cart.add_item_to_cart(Grape.new)
cart.add_item_to_cart(Banana.new)
cart.add_item_to_cart(Banana.new)
cart.add_item_to_cart(Apple.new)
cart.add_item_to_cart(Apple.new)
cart.add_item_to_cart(Orange.new)
cart.add_item_to_cart(Orange.new)
cart.add_item_to_cart(Orange.new)

cart.find_discounts
puts Apple.new.price
puts Watermelon.new.price






