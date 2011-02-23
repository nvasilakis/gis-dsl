#!/usr/bin/ruby
# File:   A gis dbf class
# Author: Nikos Vasilakis
# email:  n.c.vasilakis@gmail.com

require "csv"

class Validation

  attr_accessor :data

  def initialize (file ="weights.csv")
    @data = [["Start","End","Result"]]
    reader = CSV.open(file, "r")
    # we have headers
    reader.shift
    reader.each do |row|
      @data << [row[0],row[1],row[2]]
    end
  end

  def normalize(weight)
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

test = Validation.new("weights.csv")
test.data[]