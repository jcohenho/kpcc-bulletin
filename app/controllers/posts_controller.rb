class PostsController < ApplicationController
  def index
    @posts = Post.find(:all, params: { limit: 5 })
  end

  def filter
    @filtered_posts = Post.find(:all, params: { query: params[:search_term], limit: 40 })
  end

end
