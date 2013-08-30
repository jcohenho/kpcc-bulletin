require 'rubygems'
require 'httparty'

class KPCC
	include HTTParty
	base_uri "http://audiovision.scpr.org/api/v1"
	attr_accessor :title, :subtitle, :byline, :published_at, :teaser, :body, :public_url, :thumbnail, :category, :video_id, :video_type
	POSTS = {}

	def initialize(options = {})
		self.title = options[:title]
		self.subtitle = options[:subtitle]
		self.byline = options[:byline]
		self.published_at = options[:published_at]
		self.teaser = options[:teaser]
		self.body = options[:body]
		self.public_url = options[:public_url]
		self.thumbnail = options[:thumbnail]
		self.category = options[:category]
		self.video_id = options[:video_id]
		self.video_type = options[:video_type]
	end

	def self.get_all_posts
		response = get('/posts.json?limit=5')
		if response.success?
			response.each do |res|

				if res['assets'].present?
					if res['assets'].first["native"].present?
						video_id = res['assets'].first["native"]["id"]
						video_type = res['assets'].first["native"]["type"]
					end
				end

				POSTS[res['id']] = self.new(title: res['title'], subtitle: res['subtitle'], byline: res['byline'], published_at: res['published_at'],
				teaser: res['teaser'], body: res['body'], public_url: res['public_url'], thumbnail: res['thumbnail'],
				category: res['category'], video_id: video_id, video_type: video_type) unless POSTS.any? {|k,v| k.include? res['id']}
			end
		else
			raise response.response
		end
		return POSTS
	end

	def self.filter(params)
		query = params[:search_term]
		response = get("/posts.json?query=#{query}&limit=40")
		if response.success?
			case params[:filter_type]
				when 'add'
					response.each do |res|

						if res['assets'].present?
							if res['assets'].first["native"].present?
								video_id = res['assets'].first["native"]["id"]
								video_type = res['assets'].first["native"]["type"]
							end
						end

						POSTS[res['id']] = self.new(title: res['title'], subtitle: res['subtitle'], byline: res['byline'], published_at: res['published_at'],
						teaser: res['teaser'], body: res['body'], public_url: res['public_url'], thumbnail: res['thumbnail'],
						category: res['category'], video_id: video_id, video_type: video_type) unless POSTS.any? {|k,v| k.include? res['id']}
					end
				when 'remove'
					POSTS.reject!{|k,v| v.title.match(/#{query}/i)}
			end
		else
			raise response.response
		end
		return POSTS
	end
end
