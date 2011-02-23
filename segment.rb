#!/usr/bin/ruby
# File:   A gis dbf class	
# Author: Nikos Vasilakis	
# email:  n.c.vasilakis@gmail.com	

require "csv"

class Segment

  @@validations = []
	attr_accessor :weight, :x_start, :y_start, :x_end, :y_end, :length, :is_leaf, :edge_id, :parent, :list_of_children

	def initialize(count)
		@weight= count
    @list_of_children = []
	end
  
  def load_values( x_start, y_start, x_end  ,y_end  ,length ,is_leaf, edge_id )
      @x_start = x_start
      @y_start = y_start
      @x_end   = x_end  
      @y_end   = y_end  
      @length  = length 
      @is_leaf = is_leaf
      @edge_id = edge_id
  end

  def add_child(child)
    @list_of_children << child
  end

  def load_validations (file ="weights.csv")
    puts "Loading Validations: 0%"
    @@validations = [["Start","End","Result"]]
    reader = CSV.open(file, "r")
    # we have headers
    reader.shift
    reader.each do |row|
      @@validations << [row[0],row[1],row[2]]
    end
    puts "Loading Validations: 100%"
  end

  # return 1 if it is the leaf of the tree, 0 if not
  # TODO: Render validations from a csv file
  def normalize
    if @is_leaf == 1
      case @weight
        when 0...2 then @weight=2
        when 2...4 then @weight=4
        when 4...8 then @weight=8
        when 8...16 then @weight=16
        when 16...32 then @weight=32
        when 32...64 then @weight=64
        when 64...128 then @weight=128
        when 128...256 then @weight=256
        when 256...512 then @weight=512
        when 512...1024 then @weight=1024
        when 1024...2048 then @weight=2048
      end
      1
    else
      0
    end
  end

end
