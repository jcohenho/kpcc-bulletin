class PostsController < ApplicationController
  def index
    @posts = KPCC.get_all_posts
  end

  def filter
    @filtered_posts = KPCC.filter(params)
  end

end
