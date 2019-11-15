require 'pry'

Dir["#{Dir.pwd}/models/*.rb"].each {|file| require file }
