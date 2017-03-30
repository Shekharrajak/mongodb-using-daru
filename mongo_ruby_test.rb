#!/usr/bin/ruby

require 'mongo'
require 'daru'

Mongo::Logger.logger.level = ::Logger::FATAL

client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'testdb')

#cars table contains:
#{"_id"=>BSON::ObjectId('58dca09b2e6509b05f89443c'), "name"=>"Audi", "price"=>52642.0}

# Daru::DataFrame.new({ :a => a, :b => b })
keys = Array.new(['id', 'name', 'price'])
_id_arr = Array.new
name_arr = Array.new
price_arr = Array.new

# client.collections.each { |coll| keys.push(coll.name) }

# puts client[:cars].keys


client[:cars].find.each { |doc| _id_arr.push(Hash[doc]['_id']); name_arr.push(Hash[doc]['name']); price_arr.push(Hash[doc]['price']) }

puts keys
# id
# name
# price


id_vec = Daru::Vector.new _id_arr
name_vec = Daru::Vector.new name_arr
price_vec = Daru::Vector.new price_arr

df = Daru::DataFrame.new({ :id => id_vec, :name => name_vec, :price => price_vec})

puts df.inspect

# output:
# #<Daru::DataFrame(3x3)>
#                     id       name      price
#           0 58dca09b2e       Audi    52642.0
#           1 58dca0a02e   Mercedes    57127.0
#           2 58dca0a52e      Volvo    29000.0

#----- other test -------------
# puts
# client[:cars].find.each { |doc| puts (doc).class }
# output :
# BSON::Document
# BSON::Document
# BSON::Document

# puts
# client[:cars].find.each { |doc| puts Array(doc) }
# output :
# _id
# 58dca09b2e6509b05f89443c
# name
# Audi
# price
# 52642.0
# _id
# 58dca0a02e6509b05f89443d
# name
# Mercedes
# price
# 57127.0
# _id
# 58dca0a52e6509b05f89443e
# name
# Volvo
# price
# 29000.0

# puts
# client[:cars].find.each { |doc| puts doc }
# output:
# {"_id"=>BSON::ObjectId('58dca09b2e6509b05f89443c'), "name"=>"Audi", "price"=>52642.0}
# {"_id"=>BSON::ObjectId('58dca0a02e6509b05f89443d'), "name"=>"Mercedes", "price"=>57127.0}
# {"_id"=>BSON::ObjectId('58dca0a52e6509b05f89443e'), "name"=>"Volvo", "price"=>29000.0}


# puts
# puts client.collections
# output  : #<Mongo::Collection:0x007fd8713b8430>

# puts
# client.collections.each { |coll| puts coll.name }
# output : cars


client.close
