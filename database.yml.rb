#!/usr/bin/env ruby
require 'yaml'

#dbstr="postgres://username:password@hostname/database"
dbstr = ENV['DATABASE_URL']

unless dbstr.nil?
  value_arr = dbstr.match(/([a-z]*):\/\/(.*):(.*)@(.*)\/(.*)/i)
  unless value_arr.nil?                                                                                                                      
    db_type = value_arr[1]
    db_user = value_arr[2]
    db_pass = value_arr[3]
    db_host = value_arr[4]
    db_name = value_arr[5]
    db_encoding = ""
    db_port = ""

    case db_type.downcase
    when "postgres"
      db_adapter = "postgresql"
      db_encoding = "unicode"
      db_port = 5432
    when "mysql"
      db_adapter = "mysql2"
      db_encoding = ""
      db_port = 3306
    else
      # do nothing
    end

    db_hash = {
      'production' => {
        'encoding' => db_encoding,
        'adapter'  => db_adapter,
        'username' => db_user,
        'password' => db_pass,
        'database' => db_name,
        'host'     => db_host,
        'port'     => db_port
      }
    }
    puts "### DATABASE_URL=#{dbstr}"
    puts db_hash.to_yaml.to_s
  end
end


