class PostsController < ApplicationController
  require 'face'
  @@client = Face.get_client(api_key: ENV['SKYBIOMETRY_KEY'], api_secret: ENV['SKYBIOMETRY_SECRET'])

  def image_info 
  end

  def analyze_image
    if params[:image_url].nil?
      redirect_to '/posts/image_info', notice: 'Please select the image for face recognition'
      return
    end
    @image = @@client.faces_detect(urls: [params[:image_url]], attributes: 'all')
  end

end
