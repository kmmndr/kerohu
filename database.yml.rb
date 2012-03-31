#!/usr/bin/env ruby
require 'yaml'

#dbstr="postgres://username:password@hostname/database"
dbstr = ENV['DATABASE_URL']

unless dbstr.nil?
  value_arr = dbstr.match(/([a-z]*):\/\/(.*):(.*)@(.*)\/(.*)/i)
  unless value_arr.nil?                                                                                                                      
    db_arr = {}
    db_arr['type'] = value_arr[1]
    db_arr['user'] = value_arr[2]
    db_arr['pass'] = value_arr[3]
    db_arr['host'] = value_arr[4]
    db_arr['name'] = value_arr[5]

    case db_arr['type'].downcase
    when "postgres"
      db_arr['adapter'] = "postgresql"
      db_arr['encoding'] = "unicode"
      db_arr['port'] = 5432
    when "mysql"
      db_arr['adapter'] = "mysql2"
      db_arr['port'] = 3306
    else
      # do nothing
    end

    db_hash = {
      'production' => db_arr
    }
    puts "### DATABASE_URL=#{dbstr}"
    puts db_hash.to_yaml.to_s
  end
end


