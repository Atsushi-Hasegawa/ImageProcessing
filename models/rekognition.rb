#!/bin/env ruby
#-*- encoding -*-
require 'rekognize'
require 'yaml'

module Rekognition
  def initialize(filename)
    @config = load_config(filename)
    @client = Rekognize::Client::Base.new(api_key: @config['api_key'], api_secret: @config['api_secret'])
  end

  def load_config(filename)
    if File.exists?(filename)
      YAML.load_file(filename)
    else
      "FileNotException " + filename
    end
  end

  def face_detect(uri, job='face_search')
    begin
      url = uri.to_s
      face_position = @client.face_detect(urls: url, jobs: job)
      if !face_position.include?('face_detection')
        raise "ERROR! No image URL " + url
      end
      face_position
    rescue => e
      e.message
    ensure
      face_position
    end
  end

  def calculate(coordinate, type)
    begin
      if !coordinate.instance_of?(Array) 
        raise "Invalid format type"
      end
      sum = 0
      coordinate.each{|position|
        sum+= position[type]
      }
      sum/coordinate.length
    rescue => e
      e.message
    end
  end
end
