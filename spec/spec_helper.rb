require "pry"
require "active_record"

Dir["#{Dir.pwd}/models/*.rb"].each {|file| require file }
