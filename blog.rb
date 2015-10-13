require 'colorize'
require 'pry'

class Blog
	def initialize(page_length = 3, posts = [])
		@page_length = page_length
		@posts = posts
	end

	def add_post(post)
		@posts << post
	end

	def paginate(posts, index)
		current_page = (index / @page_length) + 1
		pages = (posts.size / @page_length.to_f).ceil
		pager = (1..pages).to_a

		pager.each do |p|
			if p == current_page
				print p.to_s.colorize(:green) + ' '
			else
				print p.to_s + ' '
			end
		end
		puts ' '
		puts ' '

		show_three_posts(posts, index, gets.chomp)
	end

	def show_three_posts(posts, index = 0, query = '')
		if query == 'prev' && index > 0
			index -= @page_length
		elsif query == 'next' && index < (posts.size - @page_length)
			index += @page_length
		elsif query == 'quit'
			return
		end

		posts[index..(index + (@page_length - 1))].each do |post|
			post.post_thumbnail
		end

		paginate(posts, index)
	end

	def publish_front_page
		ordered_posts = @posts.sort do |a, b|
			b.date <=> a.date
		end

		show_three_posts(ordered_posts)
	end
end

class Post
	attr_reader :title, :text, :date, :sponsored

	def initialize(title, text, sponsored = false)
		@title = title
		@text = text
		@sponsored = sponsored
		@date = Time.now
	end

	def post_thumbnail
		if @sponsored
			puts "*******#{@title}*******"
		else
			puts @title
		end
		puts '************'
		puts @text
		puts '---------------'
	end
end

blog = Blog.new
blog.add_post(Post.new('My First Post', "I love my new blog!"))
blog.add_post(Post.new('My Second Post', 'I still love my post!', true))
blog.add_post(Post.new('My Third Post', 'I think this blog is pretty awesome'))
blog.add_post(Post.new('My Fourth Post', 'I\'m still pretty stoked on this blog!'))
blog.add_post(Post.new('My Fifth Post', 'Yeah, this blog is pretty cool.', true))
blog.add_post(Post.new('My Sixth Post', 'I\'m sort of luke warm on this blog'))
blog.add_post(Post.new('My Seventh Post', 'Um, not sure what I think of this blog'))
blog.add_post(Post.new('My Eighth Post', 'Do I have to keep writing this blog?'))
blog.publish_front_page

