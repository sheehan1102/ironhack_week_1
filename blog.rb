class Blog
	def initialize(posts = [])
		@posts = posts
	end

	def add_post(post)
		@posts << post
	end

	def publish_front_page
		@posts.each do |post|
			post.post_thumbnail
		end
	end
end

class Post
	attr_reader :title, :text, :date, :sponsored

	def initialize(title, text, sponsored = false)
		@title = title
		@text = text
		@sponsored = sponsored
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

blog 	= Blog.new
blog.add_post(Post.new('My First Post', "I love my new blog!"))
blog.add_post(Post.new('My Second Post', 'I still love my post!', true))
blog.add_post(Post.new('My Third Post', 'I think this blog is pretty awesome'))
blog.publish_front_page

