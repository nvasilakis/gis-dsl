#!/usr/bin/ruby
# File:   parsing a dbf tree and re-calculating weights	
# Author: Nikos Vasilakis	
# email:  n.c.vasilakis@gmail.com	
# comments: below is the segment object structure
# COUNT_coun, x_start, y_start, x_end, y_end, length, is_leaf, edge_id, parent, listOfChildren

require 'rubygems' # for dbf gem
require 'segment'
require 'dbf'      # gem install dbf

class Tree

  @structure

  def initialize()
    @structure = []
  end

  def load(file)
    copy1 = DBF::Table.new(file)
    copy1.each do |record|
      row_rec = Segment.new(record.attributes["COUNT_coun"]) #note: we represent COUNT_coun as weight
      row_rec.x_start=record.attributes["x_start"]
      row_rec.y_start=record.attributes["y_start"]
      row_rec.x_end=record.attributes["x_end"]
      row_rec.y_end=record.attributes["y_end"]
      row_rec.length=record.attributes["length"]
      row_rec.is_leaf=record.attributes["is_leave"] #note: is_leaf is erroneously represented as is_leave
      row_rec.edge_id=record.attributes["edge_id"]
      puts "[debug] [load] row edge id: #{row_rec.edge_id}"
      @structure.push(row_rec)
    end
  end

  def build
    str_copy = @structure.dup
    #second Iteration to find father
    @structure.each do |segment|
      str_copy.each do |segment_copy|
        #  end(i) = start(parent(i))
        if segment_copy.x_start==segment.x_end
          segment.parent=segment_copy.edge_id
        end
        # start(i) = end(children(i))
        if segment_copy.x_end==segment.x_start
          segment.addChild(segment_copy.edge_id)
        end
      end
      puts "[debug] [build] row edge id: #{segment.edge_id}"
    end
  end

  def recalc(subtree)
    fullCount = 0
    subtree.each do |node|
      unless node.normalize==1
        # if not leaf
        recalc(holon.searchFor(node).listOfChildren)
      else  
        node.normalize
      end
      # uplogizw to sum of coun and re-normalize
      fullCount = fullCount + node.weight
    end
  end

  def get(index)
    puts "[debug] index: #{index}"
    segment = @structure[index]
    return segment
  end
end


    #if (node.is_leaf == 1)
      #node.
    #end  

holon = Tree.new
holon.load("input.dbf")
holon.build
#holon.
seg = holon.get(0)
puts " row 1 count: #{seg.class} and edge id: #{seg.class}"
#puts " row 1 count: #{records[0].weight} and edge id: #{records[0].edge_id}"


