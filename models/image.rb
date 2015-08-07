# -*- coding: utf-8 -*-
#!/usr/bin/env ruby

require 'rmagick' # require してライブラリを読み込み
require_relative 'rekognition'

class Image
  include Rekognition
  def initialize(filename, api_config)
    @img = Magick::ImageList.new(filename)
    @draw = Magick::Draw.new
    super(api_config)
  end

  def effetct_blur(x, y)
    begin
      return @img.blur_image(x, y)
    rescue ArgumentError => ex
      puts ex.message
      return x, y
    end
  end

  def resize(x,y)
    begin
      @img.resize_to_fit(x,y)
    rescue ArgumentError => ex
      puts ex.message
      return x,y
    end
  end

  def do_graffiti(scale, width, height, x, y, font, graffiti)
    @draw.annotate(scale, width, height, x, y, graffiti) do
      self.font = font
      self.fill =  'blue'
      self.stroke = 'transparent'
      self.stroke_width = 4 
      self.pointsize = 30
      self.gravity = Magick::NorthWestGravity
    end
  end

  def composite(x, y, input, output)
    begin
      input.each{|file|
        blob_img = Magick::Image.from_blob(File.read(file)).shift
        output = output.composite(blob_img, x, y, Magick::ScreenCompositeOp)
      }
      output
    rescue ArgumentError => ex
      puts ex.message
      return x, y, arg
    end
  end

  def write_file(output, outfile)
    return output.write(outfile)
  end
 
  def destroy_memory(output)
    return output.destroy!
  end
end
