class PostsController < ApplicationController
  def index
    @posts = Post.get_all_posts
  end

  def filter
    @filtered_posts = Post.filter(params)
  end

end
