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
      uri = uri.to_s
      @client.face_detect(urls: uri, jobs: job)
      raise "ERROR! No image URL " + uri
    rescue => e
      e.message
    end
  end
end

class Image
  include Rekognition
end
