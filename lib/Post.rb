require 'rubygems'
require 'active_resource'
class Post < ActiveResource::Base

  self.site = "http://audiovision.scpr.org/api/v1"

  attr_accessor :title, :subtitle, :byline, :published_at, :teaser, :body, :public_url, :thumbnail, :category, :video_id, :video_type

end
