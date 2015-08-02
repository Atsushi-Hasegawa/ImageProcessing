#!/bin/env ruby
require 'mysql'

class Database
  def initialize(host, user, passwd, dbname)
    @host = host
    @user = user
    @passwd = passwd
    @dbname = dbname
    @client = connect()
  end

  def connect()
    begin
      Mysql.connect(@host, @user, @passwd, @dbname)
    rescue => ex
      puts ex.message
      false
    end
  end
  
  def insert(image_contents)
    begin
      @stmt = @client.prepare('INSERT INTO image(image_contents) VALUES(?)')
      @stmt.execute image_contents
      true
    rescue => ex
      puts ex.message
      false
    end
  end

  def delete(id)
    begin
      @stmt = @client.prepare('DELETE FROM image WHERE id = ?')
      @stmt.execute id
      true
    rescue => e
      puts e.message
      false
    end
  end

  def select
    begin
      @client.query('SELECT * FROM image')
    rescue => ex
      puts ex.message
      false
    end
  end

  def close
    begin
      @stmt.close
    rescue Mysql::Error => e
      puts "Error: " + e.message
      false
    end
  end
end
