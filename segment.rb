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
    puts "[debug] [load_validations] Loading Validations: 0%"
    @@validations = [["Start","End","Result"]]
    reader = CSV.open(file, "r")
    # we have headers
    reader.shift
    reader.each do |row|
      @@validations << [row[0].to_i,row[1].to_i,row[2].to_i]  # Conversion from csv_cell to fixnum
    end
    puts "[debug] [load_validations] Loading Validations: 100%"
  end

  # return 1 if it is the leaf of the tree, 0 if not
  # TODO: Render validations from a csv file
  def normalize
    puts "[debug] [normalize] node weight: #{@weight.class}"
    if @is_leaf == 1
      @@validations.each do |validation|
        puts "[debug] [normalize] current validation: |#{validation[0].class}|#{validation[1]}|#{validation[2]}|"
        if (validation[0]...validation[1]) === @weight
          puts "Bang!"
          @weight=validation[2]
          break
        end
      end
      1
    else
      0
    end
  end

end
