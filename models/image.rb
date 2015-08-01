# -*- coding: utf-8 -*-
#!/usr/bin/env ruby

require 'rmagick' # require してライブラリを読み込み

class Image
  def initialize(filename)
    @filename = File::expand_path(filename)
    @img = Magick::ImageList.new(filename)
    @draw = Magick::Draw.new
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
      return @img.resize_to_fit(x,y)
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

  def composite(x, y, arg, result)
    begin 
      arg.each{|file|
        blob_img = Magick::Image.from_blob(File.read(file)).shift
        scale_img = blob_img.resize(x, y)
        result = result.composite(scale_img, Magick::SouthEastGravity, Magick::ScreenCompositeOp)
      }
      return result
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
