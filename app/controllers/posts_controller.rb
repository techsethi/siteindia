class PostsController < ApplicationController
  require 'face'
  require 'mini_magick'
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

  def analyzed_image_path
    if params[:image_url].nil?
      redirect_to '/posts/image_info', notice: 'Please select the image for face recognition'
      return
    end
    image = MiniMagick::Image.open(params[:image_url])
    image_data = @@client.faces_detect(urls: [params[:image_url]], attributes: 'all')
    image_data["photos"].each do |photo|
      colors = ["red", "green","yellow", "blue"] 
      photo["tags"].each_with_index do |tag, index|
        draw_color =  colors[index % 4]
        image.combine_options do |c|
          # draw center
          x0 = tag['center']['x'] * photo["width"] / 100
          y0 = tag['center']['y'] * photo["height"] / 100
          x1 = x0 + 60
          y1 = y0
          c.fill 'none'
          c.stroke draw_color
          c.draw "stroke-width 1 circle #{x0},#{y0},#{x1},#{y1}"

          # draw mouth center
          x0 = tag['mouth_center']['x'] * photo["width"] / 100
          y0 = tag['mouth_center']['y'] * photo["height"] / 100
          x1 = x0 + 10
          y1 = y0
          c.fill 'none'
          c.stroke draw_color
          c.draw "stroke-width 1 circle #{x0},#{y0} #{x1},#{y1}"

          # draw mouth center
          x0 = tag['eye_left']['x'] * photo["width"] / 100
          y0 = tag['eye_left']['y'] * photo["height"] / 100
          x1 = x0 + 10
          y1 = y0
          c.fill 'none'
          c.stroke draw_color
          c.draw "stroke-width 1 circle #{x0},#{y0} #{x1},#{y1}"

          # draw mouth center
          x0 = tag['eye_right']['x'] * photo["width"] / 100
          y0 = tag['eye_right']['y'] * photo["height"] / 100
          x1 = x0 + 10
          y1 = y0
          c.fill 'none'
          c.stroke draw_color
          c.draw "stroke-width 1 circle #{x0},#{y0} #{x1},#{y1}"
        end
      end
    end
    send_file image.path,  disposition: 'inline'
    
  end
end
